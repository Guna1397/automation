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
    return "JAYU-2393"


@scenario('test_JAYU-2393.feature', 'Org does not exist')
def test_JAYU_2393():
    pass

@given('User (super admin) want to make org data non accessible to anyone from DSP')
def prepare_autherization_token():
    logger.info('Step:1')
    baseurl = os.environ["org_api_url"]
    try:
        logger.info(f"ORG API Service base URL : {baseurl} ")
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
        Invalid_org_ID = os.getenv('invalid_dsep_org_id')
        baseurl = os.environ["org_api_url"]
        endpoint = baseurl + "/" + Invalid_org_ID
        logger.info("Preparing OKTA token to authenticate new OrgAPI")
        token = os.getenv("valid_okta_token")
        logger.info("OKTA token prepared successfully")
        logger.info(f"The invalid Organization name is : {Invalid_org_ID} ")
        logger.info(f" ORG Service API URL : {endpoint}")
        response = requests.delete(endpoint, headers=headers, data=json.dumps(json_data))
        response_data = response.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall error out the request with 404 NOT FOUND')
def verify_status_code():
    logger.info("Step:3")
    expected_status_code = 404
    response_reason = response.reason
    try:
        assert expected_status_code == response.status_code
        logger.info(f"The status code from the response is : {response.status_code} {response_reason}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status