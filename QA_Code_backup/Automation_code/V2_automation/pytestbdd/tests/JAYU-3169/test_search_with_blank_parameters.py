from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Search with blank parameters'

@scenario('test_search_with_blank_parameters.feature', str(scenario_name))
def test_JAYU():
    pass
@given('User wants to retrieve Practitioner details using Practitioner API')
def prepare_autherization_token():
    global baseurl
    logger.info('Step:1')
    try:
        baseurl = os.environ["practitioner_api_url"]
        logger.info(f"Practitioner API URL used to retrieve Practitioner details is : {baseurl}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('API call is made with blank IDs')
def send_an_api_request():
    logger.info('Step:2')
    global response, token
    try:
        token = os.getenv("velys_okta_token")   
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.32.2',
            'Content-Type': 'application/json'}
        json_data = {}
        endpoint = f"{baseurl}"
        logger.info(f"Practitioner API URL made with blank ID is : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('API gives 200 response code')
def verify_response_code():
    logger.info("Step:3")
    expected_status_code = 200
    try:
        assert expected_status_code == response.status_code
        logger.info(f"The response code from the response is : {response.status_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('All Practitioners details are retrieved from DSP')
def verify_response_data():
    try:
        logger.info(f"All Practitioners details retrieved from DSP is : {response.json()}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)

