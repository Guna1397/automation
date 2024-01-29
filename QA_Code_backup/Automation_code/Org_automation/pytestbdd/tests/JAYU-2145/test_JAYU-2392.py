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
    return "JAYU-2392"

@scenario('test_JAYU-2392.feature', 'User does not have valid permission')
def test_JAYU_2392():
    pass


@given('User (not a super admin) want to make org data non accessible to anyone from DSP')
def prepare_url():
    logger.info('Step:1')
    global  token

    try:
        baseurl = os.environ["org_api_url"]
        logger.info(f"ORG API Service base URL : {baseurl} ")
        logger.info("Preparing OKTA token to authenticate new OrgAPI")
        token = os.getenv("okta_app_admin")
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
            "Authorization": os.environ["okta_app_admin"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        valid_org_ID = os.getenv('valid_dsep_org_id')
        baseurl = os.environ["org_api_url"]
        endpoint = f"{baseurl}/{valid_org_ID}"
        logger.info("OKTA token using App Admin has been prepared successfully")
        logger.info(f" ORG Service API URL : {endpoint}")
        logger.info("Unable to De-activate organization with App Admin permissions")
        response = requests.delete(endpoint, headers=headers, data=json.dumps(json_data))
        response_data = response.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall not process the request and error out with 401 Access Denied')
def verify_response_code():
    logger.info("Step:3")
    expected_status_code = 401
    code = response.reason
    try:
        assert expected_status_code == response.status_code
        logger.info(f"The response code from the response is : {response.status_code} {code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status
