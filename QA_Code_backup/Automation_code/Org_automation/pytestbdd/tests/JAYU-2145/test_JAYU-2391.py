import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]


@pytest.fixture()
def test_jira_id():
    return "JAYU-2391"


@scenario('test_JAYU-2391.feature', 'User has valid permission')

def test_JAYU_2391():
    pass


@given('User (super admin) want to make org data non accessible to anyone from DSP')
def prepare_autherization_token():
    logger.info('Step:1')
    try:
        baseurl = os.environ["org_api_url"]
        logger.info(f"ORG API Service base URL : {baseurl} ")
        logger.info("Preparing OKTA token to authenticate new OrgAPI")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Request is made to DSP with DSP Org ID')
def send_an_api_request():
    logger.info('Step:2')
    global response_data, response, token
    try:
        headers = {
            "Authorization": os.environ["valid_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        valid_org_ID = os.getenv('valid_dsep_org_id')
        baseurl = os.environ["org_api_url"]
        endpoint = f"{baseurl}/{valid_org_ID}"
        logger.info("Preparing OKTA token to authenticate new OrgAPI")
        token = os.getenv("valid_okta_token")
        logger.info("OKTA token prepared successfully")
        logger.info(f" ORG Service API URL : {endpoint}")
        response = requests.delete(endpoint, headers=headers, data=json.dumps(json_data))
        logger.info("Organization De-activated successfully with Super Admin permissions")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall make org data unavailable to any users from DSP')
def verify_response_code():
    logger.info("Step:3")
    expected_status_code = 204
    response_reason = response.reason
    code = response.status_code
    print(code)
    try:
        assert expected_status_code == code
        logger.info(f"The status code from the response is : {code} {response_reason}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status