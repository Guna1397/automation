import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,random,uuid
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = "Patient Data exists"

@scenario('test_patient_data_update.feature', str(scenario_name))
def test_JAYU():
    pass
@given('The Patient data payload is posted by source')
def prepare_url():
    logger.info('Step:1')
    global endpoint,headers,dump_data,mrn_number
    try:
        with open('../test-data/JAYU-3641/patient_update_valid.json') as data:
            loaded_data = json.load(data)
        dump_data = json.dumps(loaded_data)
        mrn_number="MRNID"+str(random.randint(10000,99999))
        for var in ["mrn_number"]:
            dump_data = dump_data.replace("{{"+var+"}}",eval(var))
        token = os.environ["docspera_okta_token"]
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json',
            'x-ms-blob-type':'BlockBlob'}
        baseurl = os.environ["patient_api_url"]
        pat_id = os.environ["pat_id"]
        endpoint = f"{baseurl}/{pat_id}"
        logger.info(f"The Patient data payload is posted by source is : {dump_data}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@when('Payload is consumed by DSP')
def send_an_api_request():
    logger.info('Step:2')
    global result_data,code
    try:
        logger.info(f"The endpoint used by DSP to consume the payload is : {endpoint}")
        response = requests.put(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        result_data = response.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall validate the resource data against existence')
def verify_response_code():
    logger.info("Step:3")
    assert code == 201
    logger.info(f'The Response code for the request is : {code}')


@then('System updates the resource')
def verify_response_code():
    logger.info("Step:4")
    # mrn = result_data["resourceType"]["identifier"][0]["value"]
    # assert mrn_number == mrn
    logger.info(f'The response for updated resource is : {result_data}')
    assert result_data["Message"] == "Successfully Updated Patient and Resources"
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)