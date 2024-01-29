from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,uuid
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Data exists'

@scenario('test_update_data.feature', str(scenario_name))
def test_JAYU():
    pass
@given('The data payload is posted by source (DocSPera or Velys)')
def post_data_payload():
    logger.info('Step:1')
    global endpoint,headers,dump_data,trans_id,patient_identifier,docspera_id,mrn_number,valid_dsp_patient_id
    try:
        with open('../test-data/JAYU-3153/resource_test_data_update.json') as data:
            loaded_data = json.load(data)
        dump_data = json.dumps(loaded_data)
        docspera_id=os.environ["valid_docspera_mr_id"]
        mrn_number=os.environ["valid_mrn"]
        patient_identifier=str(uuid.uuid4())
        valid_dsp_patient_id = os.environ["valid_dsp_patient_id"]
        trans_id = str(uuid.uuid4())
        token = os.environ["docspera_okta_token"]
        for var in ["docspera_id","mrn_number","patient_identifier","valid_dsp_patient_id","trans_id"]:
            dump_data = dump_data.replace("{{"+var+"}}",eval(var))
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json',
            'x-ms-blob-type':'BlockBlob'}
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}/{valid_dsp_patient_id}"
        logger.info(f"Data payload posted by source (DocSPera or Velys) is : {dump_data}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@when('Payload is consumed by DSP')
def send_api_request():
    logger.info('Step:2')
    global result_data
    try:
        logger.info(f"The endpoint used by source (DocSPera or Velys) to ingest the data is : {endpoint}")
        response = requests.put(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        result_data = response.json()
        assert code == 201
        logger.info(f'The Response code is : {code}')
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall validates the resource data against exitance')
def verify_response_data():
    logger.info("Step:3")
    try:
        assert result_data["Message"] == "Successfully Updated Patient and Resources"
        logger.info(f'The Response is : {result_data}')
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System updates the resource')
def verify_updation_data():
    logger.info("Step:4")
    logger.info(f"The generated DSEP Patient ID from the system for updated record is : {valid_dsp_patient_id}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)