from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests
from test.pytestbdd.tests import create_json


with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Valid Org ID is provided'

@scenario('test_deltachange_valid_orgid_provided.feature', str(scenario_name))
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
    
@when('Valid organization ID and "From" date in epoch format passed in API')
def send_an_api_request():
    logger.info('Step:2')
    global response_data, response, validEpochfrom, token       
    try:        
        token = os.getenv("velys_okta_token")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        valid_org_ID = os.getenv('valid_dsep_org_id')
        validEpochfrom = os.getenv('Epochfrom')
        endpoint = f"{baseurl}?org_id={valid_org_ID}&epoch_from={validEpochfrom}"
        logger.info(f"Delta Change API URL with valid Org ID and valid epoch from is : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        response_data = response.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('API gives 200 response code')
def verify_response_code():
    logger.info("Step:3")
    expected_status_code = 200
    code = response.status_code
    try:
        assert expected_status_code == code
        logger.info(f"The response code from Delta Change API is : {code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status
    
    
@then('API provides the details of resources for the given Organization ID within the date range')    
def verify_response_code2():
    logger.info("Step:4")
    logger.info(f"The response from Delta Change API is : {response_data}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)   