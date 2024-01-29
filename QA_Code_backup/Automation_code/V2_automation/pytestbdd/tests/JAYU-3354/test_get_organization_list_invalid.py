import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Practitioner does not exist within DSP'

@scenario('test_get_organization_list_invalid.feature', str(scenario_name))
def test_JAYU_3349():
    pass
@given('Practitioner data is onboarded')
def prepare_autherization_token():
    logger.info('Step:1')
    try:
        baseurl = os.environ["practitioner_api_url"]
        logger.info("Practitioner data is successfully onboarded\n")
        logger.info(f"Practitioner API URL used to retrieve Practitioner details is : {baseurl}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Practitioner retrieval request is made by user for specific practitioner org')
def send_an_api_request():
    logger.info('Step:2')
    global response_data1,response_data2,  response1, response2, token,invalid_ID1
    try:
        token = os.getenv("docspera_okta_token")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.32.2',
            'Content-Type': 'application/json'}
        json_data = {}
        baseurl = os.environ["practitioner_api_url"]
        invalid_ID1 = os.environ["pract_invalid_dsp_id"]
        endpoint1 = f"{baseurl}/{invalid_ID1}/organizations"
        logger.info(f"Practitioner API URL used to retrieve Organization for specific practitioner is : {endpoint1}")
        # logger.info(f" Practitioner API URL using valid DSP ID : {endpoint1}")
        response1 = requests.get(endpoint1, headers=headers, data=json.dumps(json_data))
        response_data1 = response1.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Practitioner ID is passed')
def verify_response_code():
    logger.info("Step:3")
    expected_status_code = 200
    try:
        assert expected_status_code == response1.status_code
        logger.info(f"Practitioner ID passed in the URL is : {invalid_ID1}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall provide a 0 result back to user')
def verify_response_data():
    logger.info("Step:4")
    resp = response_data1["total"]
    assert  resp == 0
    logger.info(f"The response code from the response is : {response1.status_code}\n")
    logger.info(f'Response message is : {response_data1}\n')
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)
