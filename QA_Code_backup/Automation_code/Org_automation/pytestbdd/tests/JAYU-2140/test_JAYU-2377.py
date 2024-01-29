from pytest_bdd import given, scenarios, then, when, scenario
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
    return "JAYU-2377"

@scenario('test_JAYU-2377.feature', 'Org is existing')
def test_JAYU_2377():
    pass
@given('User needs to retrieve an organization')
def prepare_authorization_token():
    logger.info('Step:1')
    global token
    try:
        logger.info("Preparing OKTA token to authenticate new OrgAPI for retrieving organizations data")
        token = os.getenv("valid_okta_token")
        logger.info("OKTA token prepared successfully")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Retrieval request is made')
def prepare_api_url():
    logger.info('Step:2')
    global response_data
    try:
        headers = {
            "Authorization": os.environ["valid_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        valid_org_name = os.getenv('valid_org_Name')
        baseurl = os.environ["org_api_url"]
        endpoint = f"{baseurl}?name={valid_org_name}"
        logger.info(f"Organization fetch API url : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        response_data = response.json()
        logger.info(response_data)
        logger.info("Preparing API GET method url for retrieving organizations data ")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Search criteria (any or combination) such as address (city, state, country), name, phone, DSP Org ID and Alias ID is passed')
def search_with_dsp_id():
    logger.info('Step:3')
    global valid_org_city,response_data
    try:
        headers = {
            "Authorization": os.environ["valid_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        valid_org_city = os.getenv('valid_org_city')
        baseurl = os.environ["org_api_url"]
        endpoint = f"{baseurl}?address.city={valid_org_city}"
        logger.info(f"Organization fetch API url : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        response_data = response.json()
        logger.info("Organization searched with  Org city")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall provide API based solution to retrieve an Org')
def send_an_api_request():
    logger.info('Step:4')
    global response_data,response,valid_dsp_id
    try:
        headers = {
            "Authorization": os.environ["valid_okta_token"],
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        json_data = {}
        valid_dsp_id = os.getenv('valid_dsep_org_id')
        baseurl = os.environ["org_api_url"]
        endpoint = f"{baseurl}/{valid_dsp_id}"
        logger.info(f"Organization fetch API url : {endpoint}")
        response = requests.get(endpoint,headers=headers, data=json.dumps(json_data))
        response_data = response.json()
        logger.info(f"Organization fetch API got response code : {response.status_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('Success response is generated with Org data')
def verify_response():
    logger.info('Step:5')
    try:
        assert valid_dsp_id == response_data["identifier"]
        logger.info("Verified the New Org API GET method working fine")
        logger.info(f'The given parameter (DSP Org ID) "{valid_dsp_id}" and identifier from the response "{response_data["identifier"]}" both are same')
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status