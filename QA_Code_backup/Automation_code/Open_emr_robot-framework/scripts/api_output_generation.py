import os
from tabulate import tabulate

class  api_output_generation:
 def generate_api_html_report(self, testCase):
    os.chdir('./')
    output_dir_files = os.listdir('./')
    api_output_file = ""
    result = ""
    table = [[""]]
    tmpFile = "api_output_" + testCase

    for file in output_dir_files:
        if tmpFile in file:
            api_output_file = file
        if api_output_file:
            break
    if not api_output_file:
        return "API OUTPUT FILE NOT FOUND"
    with open(api_output_file, 'rb') as file:
        for cnt, line in enumerate(file):
            line_value = line.decode("utf-8")
            if "" in line_value:
                table.append([line_value.strip('\r')])
            if not "FAIL" in line_value:
                result = "API Configuration Test Passed"
            else:
                result = "API Configuration Test Failed"
                # break
    f = open("api_output_"+testCase+".html", "w+")
    f.write(tabulate(table, tablefmt="html"))
    return result
