from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests
from test.pytestbdd.tests import create_json


# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Search at patient level'

@scenario('test_search_at_patient_level.feature', str(scenario_name))
def test_JAYU_3168():
    pass


@given('Patient data is stored within DSP')
def prepare_url():
    logger.info('Step:1')
    global token

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

@when('Access patient API using Patient DSP ID')
def send_an_api_request():
    logger.info('Step:3')
    global response_data, response, token, valid_ID
    try:
        token = os.getenv("velys_okta_token")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.32.2',
            'Content-Type': 'application/json'}
        json_data = {}
        valid_ID = os.getenv('valid_dsp_id')
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}/{valid_ID}"
        logger.info(f"User wants to Access patient API using Patient DSP ID is : {endpoint}")
        response = requests.get(endpoint, headers=headers, data=json.dumps(json_data))
        status1 = response.status_code        
        response_data = response.json()
        for i in response_data["entry"][0]["resource"]["identifier"]:
            try:
                if i["type"]["coding"][0]["display"] == "DSEP PatientID":
                    dspvalue = i["value"]
            except:
                pass
        assert dspvalue == valid_ID
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
        assert test_status

@then('System shall provide result back to user with matching records')
def verify_response_code():
    logger.info("Step:4")
    expected_status_code = 200
    assert expected_status_code == response.status_code
    logger.info(f"The status code from the response is : {response.status_code}")
    logger.info(f"The response for Patient API is : {response.json()}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)
