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

scenario_name = "Patient resource is ingested as individual resource"

@scenario('test_patient_ingest_individual_resource.feature', str(scenario_name))
def test_JAYU():
    pass
@given('User needs to ingest the patient data to DSP')
def prepare_url():
    logger.info('Step:1')
    global endpoint,headers,dump_data,mrn_number,baseurl
    try:
        with open('../test-data/JAYU-3355/patient_add.json') as data:
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
        endpoint = f"{baseurl}"
        logger.info(f"The Patient data payload that needs to be ingested to DSP is : {dump_data}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@when('Payload is posted to DSP')
def send_an_api_request():
    logger.info('Step:2')
    global result_data,code
    try:
        logger.info(f"The endpoint used by DSP to post the payload is : {endpoint}")
        response = requests.post(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        result_data = response.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System ingest the data within DSP')
def verify_response_code():
    logger.info("Step:3")
    global valid_dsp_patient_id
    assert code == 201
    logger.info(f'The Response code for the request is : {code}\n')
    logger.info(f'The response for creation of new record is : {result_data}')
    valid_dsp_patient_id = result_data["dsp_patient_id"]

@then('System generates the DSP ID for ingested resource')
def verify_response_code():
    logger.info("Step:4")
    endpoint = f"{baseurl}/{valid_dsp_patient_id}"
    get_response = requests.get(endpoint, headers=headers, data=dump_data)
    resp = get_response.json()
    dsp_id = resp["identifier"][0]["value"]
    assert valid_dsp_patient_id == dsp_id
    logger.info(f"DSP ID generated for ingested resource is : '{dsp_id}'")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)