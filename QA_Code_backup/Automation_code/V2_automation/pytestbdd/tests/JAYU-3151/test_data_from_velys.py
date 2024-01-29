import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,random
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = "Data coming from Velys"

@scenario('test_data_from_velys.feature', str(scenario_name))
def test_JAYU():
    pass
@given('Velys application has clinical data to be ingested into DSP')
def prepare_url():
    logger.info('Step:1')
    global endpoint,headers,dump_data,mrn_number
    try:
        with open('../test-data/JAYU-3151/resource_test_data_velys.json') as data:
            loaded_data = json.load(data)
        dump_data = json.dumps(loaded_data)
        mrn_number="MRNID"+str(random.randint(10000,99999))
        for var in ["mrn_number"]:
            dump_data = dump_data.replace("{{"+var+"}}",eval(var))
        token = os.environ["velys_okta_token"]
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json',
            'x-ms-blob-type':'BlockBlob'}
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}"
        logger.info(f"Clinical data from Velys is : {dump_data}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@when('Velys application post the data to DSP')
def send_an_api_request():
    logger.info('Step:2')
    global result_data
    try:
        logger.info(f"The endpoint used by Velys to ingest the data is : {endpoint}")
        response = requests.post(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        assert code == 201
        result_data = response.json()
        logger.info(f'The Response code is : {code}')
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall provide a solution to consume the clinical data payload from Velys application')
def verify_response_code():
    logger.info("Step:3")
    logger.info(f'The response after consuming the clinical data is : {result_data}')
    assert result_data["entry"][0]["response"]["status"] == "201 Created"
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)
