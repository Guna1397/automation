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

scenario_name = "Data coming from DocSpera"

@scenario('test_data_from_docspera.feature', str(scenario_name))
def test_JAYU():
    pass
@given('User needs clinical data coming from DocSpera')
def prepare_url():
    logger.info('Step:1')
    global endpoint,headers,dump_data,trans_id,patient_identifier,docspera_id,mrn_number
    try:
        with open('../test-data/JAYU-3151/resource_test_data_docspera.json') as data:
            loaded_data = json.load(data)
        dump_data = json.dumps(loaded_data)
        docspera_id="DocsMRID"+str(random.randint(10000,99999))
        mrn_number="MRNID"+str(random.randint(10000,99999))
        patient_identifier=str(uuid.uuid4())
        for var in ["docspera_id","mrn_number","patient_identifier"]:
            dump_data = dump_data.replace("{{"+var+"}}",eval(var))
        token = os.environ["docspera_okta_token"]
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json',
            'x-ms-blob-type':'BlockBlob'}
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}"
        logger.info(f"Clinical data from Docspera is : {dump_data}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@when('DocSpera ingest the data to DSP by posting a payload')
def send_an_api_request():
    logger.info('Step:2')
    global result_data
    try:
        logger.info(f"The endpoint used by DocSpera to ingest the data is : {endpoint}")
        response = requests.post(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        assert code == 201
        result_data = response.json()
        logger.info(f'The Response code : {code}')
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall provide a solution to consume the clinical data payload from DocSpera')
def verify_response_code():
    logger.info("Step:3")
    dsp_patient_id = result_data["dsep_patient_id"]
    logger.info(f'The response after consuming the clinical data is : {result_data}')
    assert result_data["Message"] == "Successfully Created Patient and Resources"
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)