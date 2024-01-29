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

scenario_name = 'Valid Org ID is not provided'

@scenario('test_deltachange_Invalid_orgid_provided.feature', str(scenario_name))
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
       
    

@when('Invalid organization ID is and "From" date in epoch format passed in API')
def send_an_api_request():
    logger.info('Step:2')
    global status1, reason, verifyreason
    
    try:
        token = os.getenv("velys_okta_token")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json',
            'Content-Type': 'application/json'}
        json_data = {}
        in_valid_org_ID = os.getenv('invalid_dsep_org_id')
        validEpochfrom = os.getenv('Epochfrom')
        endpoint = f"{baseurl}?org_id={in_valid_org_ID}&epoch_from={validEpochfrom}"
        logger.info(f"Delta Change API URL with invalid Org ID and valid epoch from is : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        status1 = response.status_code
        reason = response.json()
        verifyreason = reason["resource_count"] 
        test_status = True
        
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('API gives 200 response code')
def verify_response_code():
    logger.info("Step:3")       
    expected_status1_code = 200
    try:
        assert expected_status1_code == status1
        logger.info(f"The response code from Delta Change API is : {status1}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

    
@then('Results back to user with 0 count')    
def verify_response_code2():
    logger.info("Step:4")
    assert verifyreason == 0
    logger.info(f"The response from Delta Change API is : {reason}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)   
            
