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

scenario_name = 'Missing MRN number or OID'

@scenario('test_missing_mrn.feature', str(scenario_name))
def test_JAYU():
    pass
@given('User wants to retrieve Patient details from DSP using MRN & organization ID')
def User_wants_to_retrieve_Patient_details_from_DSP_using_MRN():
    logger.info('Step:1')
    global valid_mrn,valid_internal_oid,baseurl,headers,endpoint
    try:
        headers = {
            "Authorization": os.environ["velys_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        valid_mrn = os.getenv('valid_mrn')
        valid_internal_oid = os.getenv("valid_internal_oid")
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}/organizations/{valid_internal_oid}/mrn/"
        logger.info(f"MRN Search API used to retrieve patient details from DSP using MRN & organization ID is : {baseurl}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('During search MRN is missing')
def missing_mrn():
    logger.info('Step:2')
    global status_code,result_json
    try:
        logger.info(f" MRN Search API URL missing MRN and OID : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=None)
        result_json = response.json()
        status_code = response.status_code
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('API gives 400 response code')
def API_gives_400_response_code():
    logger.info('Step:3')
    try:
        assert status_code == 400
        logger.info(f"Status code from MRN Search API is : {status_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('Returns no result back to user')
def error_message_received():
    logger.info("Step:4")
    logger.info(f"Response from MRN Search API is : {result_json}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)