from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests
from test.pytestbdd.tests import create_json


# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Patient data exists'

@scenario('test_patient_fetch_name_dob.feature', str(scenario_name))
def test_JAYU_3357():
    pass

@given('Patient data is stored within DSP')
def prepare_url():
    logger.info('Step:1')
    try:
        logger.info("User wants to retrieve the patient data which is stored within DSP")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('User wants to access patient data')
def send_an_api_request():
    logger.info('Step:2')
    try:
        baseurl = os.environ["patient_api_url"]
        logger.info(f"User wants to access patient data using Patient API URL : {baseurl} ")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Access patient API using First Name, Last Name, Date of Birth')
def send_an_api_request():
    logger.info('Step:3')
    global response_data, response, token, valid_ID,response1,response2
    try:
        token = os.getenv("docspera_okta_token")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.32.2',
            'Content-Type': 'application/json'}
        json_data = {}
        first_name = os.getenv('first_name')
        last_name = os.getenv('last_name')
        DOB = os.getenv('DOB')
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}/id-key/first_name/id-value/{first_name}"
        endpoint1 = f"{baseurl}/id-key/last_name/id-value/{last_name}"
        endpoint2 = f"{baseurl}/id-key/birth_date/id-value/{DOB}"
        logger.info(f"The endpoint for accessing patient API using First Name is : {endpoint}\n")
        logger.info(f"The endpoint for accessing patient API using Last Name is : {endpoint1}\n")
        logger.info(f"The endpoint for accessing patient API using Date of Birth is : {endpoint2}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        response1 = requests.get(endpoint1, headers=headers, data=json.dumps(json_data))
        response2 = requests.get(endpoint2, headers=headers, data=json.dumps(json_data))
        status1 = response.status_code
        response_data = response.json()
        test_status = True
        assert test_status
    except Exception as e:
        logger.error(e)
        test_status = False
        assert test_status

@then('System shall provide result back to user with matching records')
def verify_response_code():
    logger.info("Step:4")
    expected_status_code = 200
    assert expected_status_code == response.status_code
    logger.info(f"The status code from the response is : {response.status_code}\n")
    logger.info(f"The response for Patient API using First Name is : {response.json()}\n")
    logger.info(f"The response for Patient API using Last Name is : {response1.json()}\n")
    logger.info(f"The response for Patient API using Date of Birth is : {response2.json()}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)
