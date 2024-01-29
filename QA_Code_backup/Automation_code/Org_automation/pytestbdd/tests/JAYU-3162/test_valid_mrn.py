import requests
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os
import json
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'When Patient data exists'

@scenario('test_valid_mrn.feature', str(scenario_name))
def test_JAYU():
    pass


@given('User wants to retrieve Patient details from DSP using MRN & organization ID')
def user_wants_to_retrieve_patient_details():
    logger.info('Step:1')
    global endpoint, headers, json_data, valid_mrn, valid_internal_oid
    try:

        headers = {
            "Authorization": os.environ["velys_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        valid_mrn = os.getenv('valid_mrn')
        valid_internal_oid = os.getenv("valid_internal_oid")
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}/organizations/{valid_internal_oid}/mrn/{valid_mrn}"
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
        logger.info(f"Valid MRN passed in the API is : {valid_mrn}")
        logger.info(f"Valid OID passed in the API is : {valid_internal_oid}")
        logger.info(f" MRN Search API URL with MRN and OID : {endpoint}")
        response = requests.get(endpoint, headers=headers,data=json.dumps(json_data))
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('Patient is retrieved from DSP')
def Patient_is_retrieved_from_DSP():
    logger.info("Step:3")
    global response_data
    response_data = response.json()
    valid_mrn = os.environ["valid_mrn"]
    try:
        assert response_data["entry"]["identifier"][1]["value"] == valid_mrn
        logger.info(f"Patient retrieved from DSP is : {response_data}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('API gives 200 response code returns the details of Patient FHIR resource')
def Mrn_gives_200_response_code():
    logger.info("Step:4")
    status_code = response.status_code
    assert status_code == 200
    logger.info(f"Status code for valid mrn is : {status_code}")
    logger.info(f'MRN from the response  is : {response_data["entry"]["identifier"][1]["value"]}')
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)
