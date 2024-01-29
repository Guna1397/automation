import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,uuid

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

local_path = '../test-data/JAYU-2398/'

@pytest.fixture()
def test_jira_id():
    return "JAYU-2398"

@scenario('test_JAYU-2398.feature', 'Invalid user (invalid token) resulting in an error message - update.')
def test_JAYU_2398():
    pass

@given('User is updating an Org')
def prepare_for_org_payload():
    logger.info('Step:1')
    global json_data
    try:
        logger.info("ORG API Service base URL : "+os.environ["org_api_url"])        
        with open(local_path+"test_data.json", 'r') as data:
            base_data = json.load(data)
        base_json = json.dumps(base_data)
        id = str(uuid.uuid4())
        string_data = base_json.replace("{uuid}", id)
        json_data = json.loads(string_data)
        logger.info("Organization payload created successfully")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('User does not hold valid role (invalid token passed)')
def prepare_token_and_endpoint_for_org_service_send_request():
    logger.info('Step:2')
    global result_data,response_code
    try:
        logger.info("Preparing invalid OKTA token to authenticate new OrgAPI")
        token = os.getenv("invalid_okta_token")
        logger.info("Invalid OKTA token prepared successfully")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        baseurl=os.environ["org_api_url"]+"/"+os.environ["valid_dsep_org_id"]
        logger.info(f"ORG Service API URL : {baseurl}")
        response = requests.put(baseurl,headers=headers, data=json.dumps(json_data))
        result_data = response.json()
        response_code = response.status_code
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall throw an error message 401 Access denied')
def send_an_api_request():
    logger.info('Step:3')
    try:
        assert response_code == 401
        logger.info(f"The status code from the response is : {response_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status