import argparse
import datetime
import logging
import os
import shutil
import subprocess
from copy import deepcopy
from typing import List
from typing import Optional
import base64
import json
from fpdf import FPDF
import platform

import requests
from requests.auth import HTTPBasicAuth

parser = argparse.ArgumentParser("pytest arguments")
parser.add_argument("--test_execution_id", help="Test Execution Id.", type=str)
parser.add_argument("--test_ids", help="Test Id's as comma separated values.", type=str)
parser.add_argument("--xray_upload", help="Upload to xray.", type=str)
parser.add_argument("--user_id", help="Executor user id", type=str)
parser.add_argument("--password", help="Executor password.", type=str)
parser.add_argument("--env", help="Environment.", type=str)
parser.add_argument("--story_id", help="Story Id ", type=str)

args = parser.parse_args()

test_ids = args.test_ids

test_execution_id = args.test_execution_id

story_id = args.story_id

xray_upload = args.xray_upload

user_id = args.user_id
password = args.password
env = args.env

print(test_execution_id)
print(test_ids)
print(xray_upload)

test_ids = test_ids.split(",") if test_ids else []

jira_base = 'https://jira.jnj.com'

print(test_ids)
if os.path.exists("target/"):
    shutil.rmtree('target/')


def get_result(result):
    for test_step in result[0]['elements'][0]['steps']:
        if test_step['result']['status'] != 'passed':
            return 'FAIL'
    return 'PASS'


def upload_pdf_to_jira(test_execution_id, test_id, result, user_id, password):
    result_to_import = {'testExecutionKey': test_execution_id, 'tests': []}

    result_to_import['tests'].append({"testKey": test_id,
                                      "comment": "Execution completed",
                                      "status": get_result(result)})

    file_base = f'target/cucumber-reports/{test_execution_id}/{test_id}/{test_id}'

    with open(f'{file_base}.json', "w") as f:
        f.write(json.dumps(result_to_import))
    url = f'{jira_base}/rest/raven/1.0/import/execution'
    headers = {'Accept': 'application/json',
               'Content-Type': 'application/json'}
    response = requests.post(url, data=open(
        f'{file_base}.json', 'rb'),
                             auth=HTTPBasicAuth(user_id, password), headers=headers)

    print(response.text)
    print(response.status_code)

    get_url = f"{jira_base}/rest/raven/1.0/api/testexec/{test_execution_id}/test"

    get_response = requests.get(get_url, auth=HTTPBasicAuth(user_id, password))

    if get_response.status_code != 200:
        print(f"Could not fetch from : {test_execution_id}")
        return

    tests_obj = json.loads(get_response.content)
    test_logical_id = None

    for test in tests_obj:
        if test['key'] == test_id:
            test_logical_id = test['id']

    p_url = f"{jira_base}/rest/raven/1.0/api/testrun/{test_logical_id}/attachment"

    with open(f'{file_base}.pdf', "rb") as pdf_file:
        encoded_string = base64.b64encode(pdf_file.read())
        encoded_string = str(encoded_string, "utf-8")

    payload = f'{{' \
              f'"data": "{encoded_string}", ' \
              f'"contentType": "application/pdf", ' \
              f'"filename": "{test_id}.pdf"' \
              f'}}'

    headers = {'Accept': 'application/json',
               'Content-Type': 'application/json'}

    pdf_response = requests.post(p_url, auth=HTTPBasicAuth(user_id, password),
                                 data=payload, headers=headers)



def _generate_pdf_reports(cucumber_jsons_metadata: List, env: Optional[str] = None):
    for features_dir_path, feature_name in cucumber_jsons_metadata:
        title = feature_name
        if env is not None:
            title = f"{title}-{env}"

        os.system(
            f'''mvn cukedoctor:execute -DfeaturesDir={features_dir_path} -DoutputFileName={feature_name} -Dproject-title={title}''')


def split_cucumber_report_scenarios(report, feature_name, base_dir):
    base_dir = f"{base_dir}/{feature_name}"
    os.makedirs(base_dir, exist_ok=True)

    for element in report.get("elements", []):
        name = element.get("id")
        subdir = os.path.join(base_dir, name)
        os.makedirs(subdir, exist_ok=True)

        file_path = os.path.join(subdir, "Cucumber.json")

        scenario_report = deepcopy(report)
        scenario_report["elements"] = [element]

        with open(file_path, "w") as f:
            f.write(json.dumps([scenario_report]))

        yield subdir, name


# def split_cukedoctor_report(cucumber_json_path, base_dir):
#     print("Creating PDF reports for individual features")
#     with open(cucumber_json_path, "rb") as f:
#         reports = json.load(f)
#
#     reports_to_process = []
#     for report in reports:
#         try:
#             feature_name = report["uri"].split("/")[-1].replace(".feature", "")
#         except KeyError:
#             print(f" - Error during extracting feature name from cucumber report:")
#             print(report)
#             continue
#
#         for base_dir, name in split_cucumber_report_scenarios(report, feature_name, base_dir):
#             reports_to_process.append((base_dir, name))
#
#     return reports_to_process
#

def update_cucumber_result(cucumber_json_path, log_file_path):
    with open(cucumber_json_path) as f:
        features = json.load(f)

    modified_features = []
    with open(log_file_path) as f:
        logs_for_scenarios = f.readlines()
    for data in features:

        data = dict(data)
        i = 0
        for steps in data['elements'][0]['steps']:
            lines_for_test = []
            i += 1
            append_lines = False

            for log in logs_for_scenarios:

                if log.lower().__contains__(f'Step:{str(i)}'.lower()):

                    if lines_for_test.__len__() == 0:
                        append_lines = True

                if (lines_for_test.__len__() != 0 and "--- Step:".lower() in log.lower() and int(
                        log.split("--- Step:")[1]) != i) or (
                        lines_for_test.__len__() != 0 and "--- Step:".lower() in log.lower() and int(
                        log.split("--- Step:")[1]) == i):
                    append_lines = False

                if append_lines:
                    lines_for_test.append(log)

            steps['output'] = lines_for_test

        modified_features.append(data)

    with open(cucumber_json_path, "w") as f:
        f.write(json.dumps(modified_features))

    return modified_features


def pdf_generate(cucumber_json_path, base_dir, test_id, test_execution_id, start_time, end_time, total_time, assignee):
    class PDF(FPDF):
        def header(self):
            with pdf.rotation(40, x=100, y=180):
                with pdf.local_context(fill_opacity=0.07):
                    pdf.image("J&J.svg", 30, 130, 200)

        def footer(self):
            # Position cursor at 1.5 cm from bottom:
            self.set_y(-15)
            self.set_text_color(152, 154, 156)
            # Setting font: helvetica italic 8
            self.set_font("helvetica", "I", 8)
            # Printing page number:
            self.cell(0, 11, f"Page {self.page_no()}/{{nb}}", align="C")

    pdf = PDF()
    pdf.set_font_size(12)
    pdf.add_page()

    running_platform = platform.system()

    # Opening JSON file
    f = open(cucumber_json_path)

    # returns JSON object as
    # a dictionary
    elements = json.load(f)[0]['elements'][0]

    steps = elements['steps']

    test_pass = True

    for step in steps:

        if 'fail' in step.get('result').get('status'):
            test_pass = False

    # pdf.set_auto_page_break(True, 14)

    pdf.write_html(f"""<!DOCTYPE>
    <body><center><h1>Test Execution Report</h1></center>

    <p><b>Test Case Name: </b><span>{elements.get('name')}</span></p>
    <p><b>Jira Test Execution ID: </b><span>{test_execution_id}</span></p>
    <p><b>Jira Test Case ID: </b><span>{test_id}</span></p>
    <p><b>Assignee: </b><span>{assignee}</span></p>
    <p><b>Executed By: </b><span>{user_id}</span></p>
    <p><b>Test Type: </b><span>System</span></p>
    <p><b>Environment: </b><span>{env}</span></p>
    <p><b>OS: </b><span>{running_platform}</span></p>
    <p><b>Test Result: </b><span><font{' color="#1bc449"' if test_pass else ' color="#c41b1b"'}size="18">{'Passed' if test_pass else 'Failed'}</font></span></p>

    <h2>Test Execution Time:</h2>

    <table border="1">
        <tbody>
        <tr>
            <th width="33%">&nbsp;Test Start Time</th>
            <th width="33%">&nbsp;Test End Time</th>
            <th width="33%">&nbsp;Test Total time</th>
        </tr>
        <tr>
            <td width="33%" align='center'>&nbsp;{start_time}</td>
            <td width="33%" align='center'>&nbsp;{end_time}</td>
            <td width="33%" align='center'>&nbsp;{total_time} seconds
            </td>
        </tr>
        </tbody>
    </table>
    </body>
    """)

    pdf.add_page()

    for index, step in enumerate(steps):
        # pdf.set_auto_page_break(True, 14)

        pdf.set_font("Times", size=12)
        status = step.get('result').get('status')
        pdf.write_html(f"""<!DOCTYPE>
        <body>
        {'<h2>Execution Details:</h2>' if index == 0 else ''}
        <h2>Step: {index + 1} <font{' color="#1bc449"' if 'pass' in status else ' color="#c41b1b"'} size="18">{'Passed' if 'pass' in status else 'Failed'}</font></h2>
        <p align="left"><b>{step.get('keyword')}:</b></p>
        <p><b>{step.get('name')}:</b></p>
        <p></p>

        <p><b><i>Logs:</i></b></p>
        <p>-------------------------------------------------------------------------------------------------------------------------------------</p>
        </body>""")

        line_height = pdf.font_size * 2
        col_width = pdf.epw / 1  # distribute content evenly

        for row in step.get('output'):
            pdf.set_auto_page_break(True, 14)
            pdf.set_font("Times", size=11)
            pdf.set_text_color(87, 89, 92)

            pdf.write(line_height, row)

        pdf.set_font("Times", size=12)

        pdf.write_html(f"""<p><font face="Times">-------------------------------------------------------------------------------------------------------------------------------------<font></p>
        <p><p>""")

    pdf.output(f'{base_dir}/{test_id}.pdf')


for test_id in test_ids:
    print(os.getcwd())

    base_dir = f"target/cucumber-reports/{test_execution_id}/{test_id}"
    os.makedirs(base_dir, exist_ok=True)

    cucumber_json_path = os.path.join(os.path.abspath(
        '.'), f"{base_dir}/Cucumber.json")

    log_file_path = os.path.join(os.path.abspath(
        '.'), f'{base_dir}/pytest_logs.txt')

    print(cucumber_json_path)
    print(log_file_path)
    start_time = datetime.datetime.now()
    subprocess.run(
        f"cd tests && python3.7 -m pytest {story_id}/{test_id}.py --cucumberjson={cucumber_json_path} -o log_file={log_file_path}",
        shell=True
    )

    end_time = datetime.datetime.now()

    total_time = (end_time - start_time).seconds

    start_time = start_time.strftime("%a %d %b at %H:%M:%S")

    end_time = end_time.strftime("%a %d %b at %H:%M:%S")

    with open(cucumber_json_path) as f:
        if f.read(2) == '[]':
            raise Exception("Pytest Failed")

    result = update_cucumber_result(cucumber_json_path, log_file_path)

    get_url = f"{jira_base}/rest/raven/1.0/api/testexec/{test_execution_id}/test"

    params = {"detailed": True}

    get_response = requests.get(get_url, auth=HTTPBasicAuth(user_id, password))

    assignee = None

    if get_response.status_code != 200:
        print(f"Could not fetch detail from : {test_execution_id}")
        print(get_response.status_code)
        print(get_response.content)

    else:
        tests_obj = json.loads(get_response.content)

        print(tests_obj)

        for test in tests_obj:
            if test.get("assignee"):
                assignee = test.get("assignee")

    pdf_generate(cucumber_json_path, base_dir, test_id, test_execution_id, start_time, end_time, total_time, assignee)

    # Call our function to generate PDF.

    if xray_upload == 'upload':
        upload_pdf_to_jira(test_execution_id, test_id, result, user_id, password)
    else:
        print('Skipping jira upload as upload not forced.')