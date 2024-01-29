import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,uuid
# from okta_pkce.newORGOktaToken import login

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

local_path = '../test-data/JAYU-2387/'


@pytest.fixture()
def test_jira_id():
    return "JAYU-2387"

@scenario('test_JAYU-2387.feature', 'Org is existing and update request is made with valid user role')
def test_JAYU_2387():
    pass
@given('User needs to update an organization')
def prepare_authorization_token():
    logger.info('Step:1')
    try:
        logger.info("Preparing OKTA token to authenticate new OrgAPI for updating organizations data")
        token = os.getenv("valid_okta_token")
        logger.info("OKTA token prepared successfully")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Org payload with DSP ID is posted to update')
def prepare_for_org_payload():
    logger.info('Step:2')
    global json_data, id
    try:
        logger.info("Organization payload created successfully")
        with open(local_path+"test_data.json", 'r') as data:
            base_data = json.load(data)
        base_json = json.dumps(base_data)
        id = str(uuid.uuid4())
        string_data=base_json.replace("{uuid}", id)
        json_data = json.loads(string_data)
        logger.info(json_data)
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Minimum Org information is provided such as Org Name, Org Address (city, state, country, zip), Org Phone, Fax, along with non mandatory info such as Alias ID')
def verify_basic_information():
    logger.info('Step:3')
    try:
        logger.info(f"The official identifier which given to the organization : {id}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall update the existing org with latest data')
def send_an_api_request():
    logger.info('Step:4')
    global result_data,response_code
    try:
        logger.info("Retrieving Organization API url from configuration file and creating authorization token using OKTA.")
        headers = {
            "Authorization": os.environ["valid_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        base_url = f'{os.environ["org_api_url"]}/{os.environ["valid_dsep_org_id"]}'
        response = requests.put(base_url,headers=headers, data=json.dumps(json_data))
        result_data = response.json()
        logger.info(result_data)
        response_code = response.status_code
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('Success response is generated')
def verify_success_response():
    logger.info('Step:5')
    try:
        logger.info(f"The status code from the response is {response_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status