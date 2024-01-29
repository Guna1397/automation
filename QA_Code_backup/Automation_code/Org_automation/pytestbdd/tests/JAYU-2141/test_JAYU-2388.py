import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,uuid

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

local_path = '../test-data/JAYU-2388/'

@pytest.fixture()
def test_jira_id():
    return "JAYU-2388"

@scenario('test_JAYU-2388.feature', 'Invalid user role (invalid token)')
def test_JAYU_2388():
    pass

@given('User needs to update an organization')
def prepare_invalid_authorization_token():
    logger.info('Step:1')
    try:
        logger.info("Preparing invalid OKTA token to authenticate new OrgAPI for creating organizations data")
        token = os.getenv("Invalid_okta_token")
        logger.info("Invalid OKTA token prepared successfully")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Org payload with DSP ID is posted to update')
def prepare_org_payload_invalid_token():
    logger.info('Step:2')
    global json_data, id
    try:
        logger.info("Organization payload created successfully")
        with open(local_path+"test_data.json", 'r') as data:
            base_data = json.load(data)
        base_json = json.dumps(base_data)
        id = str(uuid.uuid4())
        json_data=base_json.replace("{uuid}", id)
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Minimum Org information is provided such as Org Name, Org Address (city, state, country, zip), Org Phone, Fax, along with non mandatory info such as Alias ID')
def verify_basic_information_invalid_token():
    logger.info('Step:3')
    try:
        logger.info(f"The official identifier which given to the organization : {id}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System generates error response with 401 Access Denied')
def verify_failure_response_invalid_token():
    logger.info('Step:4')
    global result_data,response_code
    try:
        logger.info("Retrieving Organization API url from configuration file and creating authorization token using OKTA.")
        headers = {
            "Authorization": os.environ["invalid_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        response = requests.post(os.environ["org_api_url"],headers=headers, data=json.dumps(json_data))
        result_data = response.json()
        response_code = response.status_code
        assert response_code == 401
        logger.info(f"The status code from the response is {response_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status