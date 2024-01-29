import requests
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'When Patient data does not exists'

@scenario('test_invalid_mrn.feature', str(scenario_name))
def test_JAYU():
    pass

@given('User wants to retrieve Patient details from DSP using MRN & organization ID')
def user_wants_to_retrieve_patient_details():
    logger.info('Step:1')
    global endpoint,headers,json_data,In_valid_mrn,valid_internal_oid
    try:
        headers = {
            "Authorization": os.environ["velys_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        In_valid_mrn = os.getenv('In_valid_mrn')
        valid_internal_oid = os.getenv("valid_internal_oid")
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}/organizations/{valid_internal_oid}/mrn/{In_valid_mrn}"
        logger.info(f"MRN Search API used to retrieve patient details from DSP using MRN & organization ID is : {baseurl}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@when('Valid MRN (Medical Record Number) & valid OID is passed in the API')
def Valid_MRN_and_valid_OID_is_passed_in_the_API():
    logger.info('Step:2')
    global response
    try:
        logger.info(f"Invalid MRN passed in the API is : {In_valid_mrn}")
        logger.info(f" MRN Search API URL with Invalid MRN and OID : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('API gives 200 response code')
def API_gives_200_response_code():
    logger.info("Step:3")
    global response_data
    response_data = response.json()
    try:
        status_code = response.status_code
        assert status_code == 200
        logger.info(f"Status code from MRN Search API is : {status_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('Returns 0 patient records')
def Returns_0_patient_records():
    logger.info("Step:4")
    logger.info(f"Response from MRN Search API is : {response_data}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)