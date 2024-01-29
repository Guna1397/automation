import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,uuid

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

local_path = '../test-data/JAYU-2382/'

@pytest.fixture()
def test_jira_id():
    return "JAYU-2382"



@scenario('test_JAYU-2382.feature', 'User does not hold valid permission (Invalid token)')
def test_JAYU_2382():
    pass

@given('User needs to create an organization')
def prepare_for_org_payload():
    logger.info('Step:1')
    global json_data
    try:
        logger.info("Organization payload created successfully")
        with open(local_path + "test_data.json", 'r') as data:
            base_data = json.load(data)
        base_json = json.dumps(base_data)
        
        baseurl=os.environ["org_api_url"]
        logger.info(f"ORG SERVICE API URL : {baseurl}")
        
        id = str(uuid.uuid4())
        string_data=base_json.replace("{uuid}", id)
        json_data=json.loads(string_data)
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Org payload is posted')
def prepare_token_and_endpoint_for_org_service_send_request():
    logger.info('Step:2')
    global result_data,response_code
    try:
        logger.info("Preparing OKTA token to authenticate new OrgAPI")
        token = os.getenv("invalid_okta_token")
        # logger.info(token)
        logger.info("OKTA token prepared successfully")
        logger.info("Retrieving Organization API url from configuration file and creating authorization token using OKTA.")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        # logger.info(headers)
        baseurl=os.environ["org_api_url"]
        logger.info("The final Organization API url for creating Organization prepared successfully.")
        logger.info(f"ORG SERVICE API URL : {baseurl}")
        response = requests.post(baseurl,headers=headers, data=json.dumps(json_data))
        result_data = response.json()
        response_code = response.status_code
        # logger.info(response.json())
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Minimum Org information is provided such as Org Name, Org Address (city, state, country, zip), Org Phone, Fax, along with non mandatory info such as Alias ID')
def org_info():
    logger.info('Step:3')
    logger.info("test - step 3")

@then('System shall provide API based solution to consume the payload to create the organization within DSP')
def send_an_api_request():
    logger.info('Step:4')
    try:
        assert response_code == 401
        logger.info(f"The status code from the response is {response_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('Error response is generated with 401 Access Denied')
def response_id():
    logger.info('Step:5')
    logger.info("test - step 5")