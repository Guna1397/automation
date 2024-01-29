import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests
from test.pytestbdd.tests import create_json


with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Missing ORG ID or "From" date'

@scenario('test_deltachange_Missing_orgid_or_From_date.feature', str(scenario_name))
def test_JAYU_2392():
    pass


@given('User wants to retrieve the data added')
def prepare_url():
    logger.info('Step:1')    
    global baseurl
    
    try:
        baseurl = os.environ["delta_api_url"]
        logger.info(f"Delta Change API used to retrieve the data added is : {baseurl}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status
       

@when('Search criteria (Valid Organization id, "From" date) is missing')
def send_missing_org_api_request():
    logger.info('Step:2')
    global status1
    try:
        token = os.getenv("velys_okta_token")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json',
            'Content-Type': 'application/json'}
        json_data = {}
        validEpochfrom = os.getenv('Epochfrom')
        valid_org_ID = os.getenv('valid_dsep_org_id')
        endpoint = f"{baseurl}?org_id=&epoch_from={validEpochfrom}"
        logger.info(f"Delta Change API URL without Org ID and valid epoch from is : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        status1 = response.status_code
        endpoint1 = f"{baseurl}?org_id={valid_org_ID}&epoch_from="
        logger.info(f'Delta Change API URL with valid Org ID and missing "From" date is : {endpoint1}')
        test_status = True
    except Exception as e:
            logger.error(e)
            test_status = False
    assert test_status


@then('API gives 400 error response code')
def verify_response_code():
    logger.info("Step:4")
    expected_status_code = 400
    assert expected_status_code == status1
    logger.info(f"The response code from Delta Change API is : {status1}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)   

    