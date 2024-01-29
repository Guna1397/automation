from pytest_bdd import given,scenarios, then, when, scenario
from custom_logger import logger
import json,os,requests
import pytest

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]


@pytest.fixture()
def test_jira_id():
    return "JAYU-2378"
@scenario('test_JAYU-2378.feature', 'Org is not existing')

def test_JAYU_2378():
    pass

@given('User needs to retrieve an organization')
def prepare_autherization_token_invalid():
    logger.info('Step:1')
    global token
    try:
        logger.info("Preparing OKTA token to authenticate new OrgAPI for retrieving organizations data ")
        token = os.getenv("valid_okta_token")
        logger.info("OKTA token prepared successfully")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Retrieval request is made')
def prepare_api_url_invalid():
    logger.info('Step:2')
    global invalid_dsp_id
    try:
        invalid_dsp_id = os.getenv('invalid_dsep_org_id')
        logger.info("Organization searched with invalid org name")
        invalid_org_name = os.getenv('Invalid_org_Name')
        logger.info(f"Search parameter invalid org name : {invalid_org_name}")
        headers = {
            "Authorization": os.environ["valid_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        baseurl = os.environ["org_api_url"]
        endpoint_without_baseurl = f"name={invalid_org_name}"
        endpoint = f"{baseurl}/{invalid_dsp_id}?{endpoint_without_baseurl}"
        logger.info(f"Organization fetch API url : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        logger.info(response.json())
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Search criteria (any or combination) such as address (city, state, country), name, phone, DSP Org ID and Alias ID is passed')
def search_with_dsp_id_invalid():
    logger.info('Step:3')
    global response
    try:
        logger.info("Organization searched with DSP Org ID")
        logger.info(f"Search parameter invalid DSP Org ID : {invalid_dsp_id}")
        headers = {
            "Authorization": os.environ["valid_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        baseurl = os.environ["org_api_url"]
        endpoint_without_baseurl = invalid_dsp_id
        endpoint = f"{baseurl}/{endpoint_without_baseurl}"
        logger.info(f"Organization fetch API url : {endpoint}")
        response = requests.get(endpoint,headers=headers, data=json.dumps(json_data))
        logger.info(response.json())
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall return the response with 404 NOT FOUND')
def verify_response_invalid():
    logger.info('Step:4')
    try:
        logger.info(f"Organization fetch API got response code : {response.status_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status