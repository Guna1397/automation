from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests
from test.pytestbdd.tests import create_json

with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]


scenario_name = 'Ability to ingest Non FHIR data from DocSpera'

@scenario('test_ability_to_ingest_Non_FHIR_data_from_DocSpera.feature', str(scenario_name))
def test_JAYU_2392():
    pass

@given('User wants to add non-FHIR JSON (Checklist, Intake Form & Intake Smart Scheduler) from DocSpera to DSP')
def prepare_url():
    logger.info('Step:1')
    global dump_data_checklist,dump_data_intake,dump_data_smart
    try:
        with open('../test-data/JAYU-3167/checklist_test_data.json') as data:
            loaded_data = json.load(data)
        dump_data_checklist = json.dumps(loaded_data)
        with open('../test-data/JAYU-3167/Intake_test_data.json') as data1:
            loaded_data1 = json.load(data1)
        dump_data_intake = json.dumps(loaded_data1)
        with open('../test-data/JAYU-3167/Intake_smartScheduler_test_data.json') as data2:
            loaded_data2 = json.load(data2)
        dump_data_smart = json.dumps(loaded_data2)
        token1 = os.getenv("docspera_okta_token")
        logger.info(f"Non-FHIR JSON for checklist is : {dump_data_checklist}\n")  
        logger.info(f"Non-FHIR JSON for Intake Form is : {dump_data_intake}\n") 
        logger.info(f"Non-FHIR JSON for Intake Smart Scheduler is : {dump_data_smart}") 
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status    



@when('DocSpera sends the non-FHIR JSON')
def send_an_api_request():
    logger.info('Step:2')
    global response,response1,response2
    baseurl = os.environ["org_api_url"]
    valid_checklist = os.environ["checklist"]
    valid_intake = os.environ["intake"]
    valid_intakesmartscheduler = os.environ["intakesmartscheduler"]
    try:
        token = os.getenv("docspera_okta_token")
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        endpoint = f"{baseurl}/{valid_checklist}"
        endpoint1 = f"{baseurl}/{valid_intake}"
        endpoint2 = f"{baseurl}/{valid_intakesmartscheduler}"
        logger.info(f"API URL to send the non-FHIR JSON for Checklist is : {endpoint}\n")
        logger.info(f"API URL to send the non-FHIR JSON for Intake Form is : {endpoint1}\n")
        logger.info(f"API URL to send the non-FHIR JSON for Intake Smart Scheduler is : {endpoint2}")
        response = requests.post(endpoint, headers=headers, data=dump_data_checklist)
        response1 = requests.post(endpoint1, headers=headers, data=dump_data_intake)
        response2 = requests.post(endpoint2, headers=headers, data=dump_data_smart)
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('Non-FHIR JSON is moved to DSP defined data tables')
def verify_response_code():
    logger.info("Step:3")    
    try:
        expected_status1_code = 201
        assert expected_status1_code == response1.status_code
        logger.info(f"Status code from the response is {response1.status_code}")
        logger.info(f'Response message for Checklist is : {response.json()["Message"]}')
        logger.info(f'Response message for Intake form is : {response1.json()["Message"]}')
        logger.info(f'Response message for Intake smart scheduler is : {response2.json()["Message"]}')
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)