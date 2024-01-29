import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,uuid

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

local_path = '../test-data/JAYU-2395/'

@pytest.fixture()
def test_jira_id():
    return "JAYU-2395"

@scenario('test_JAYU-2395.feature', 'Invalid payload resulting in an error message - create.')
def test_JAYU_2395():
    pass

@given('User is creating an Org')
def prepare_for_org_payload():
    logger.info('Step:1')
    global token
    try:
        logger.info("ORG API Service base URL : "+os.environ["org_api_url"])        
        logger.info("Preparing OKTA token to authenticate new OrgAPI")
        token = os.getenv("valid_okta_token")
        logger.info("OKTA token prepared successfully")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Data payload is not valid')
def prepare_token_and_endpoint_for_org_service_send_request():
    logger.info('Step:2')
    global result_data,response_code
    try:
        with open(local_path+"invalid_test_data.json", 'r') as data:
            base_data = json.load(data)
        base_json = json.dumps(base_data)
        id = str(uuid.uuid4())
        string_data=base_json.replace("{uuid}", id)
        json_data=json.loads(string_data)
        logger.info("Invalid payload is created successfully")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        baseurl=os.environ["org_api_url"]
        logger.info(f"ORG Service API URL : {baseurl}")
        response = requests.post(baseurl,headers=headers, data=json.dumps(json_data))
        result_data = response.json()
        response_code = response.status_code
        logger.info(response_code)
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall throw an error message 400 BAD REQUEST')
def send_an_api_request():
    logger.info('Step:3')
    try:
        assert response_code == 400
        logger.info(f"The status code from the response is : {response_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


