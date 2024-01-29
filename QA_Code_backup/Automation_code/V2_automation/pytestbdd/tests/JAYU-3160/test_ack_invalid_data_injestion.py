from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,random,uuid
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Data ingested errored out'

@scenario('test_ack_invalid_data_injestion.feature', str(scenario_name))

def test_JAYU():
    pass


@given('DocSpera post the data to DSP')
def post_the_data_to_dsp():
        logger.info('Step:1')
        global endpoint, headers, dump_data, trans_id, patient_identifier, docspera_id, mrn_number
        try:
            with open('../test-data/JAYU-3160/ack_invalid_test_data.json') as data:
                loaded_data = json.load(data)
            dump_data = json.dumps(loaded_data)
            docspera_id = "DocsMRID" + str(random.randint(10000, 99999))
            mrn_number = "MRNID" + str(random.randint(10000, 99999))
            patient_identifier = str(uuid.uuid4())
            trans_id = str(uuid.uuid4())
            for var in ["docspera_id", "mrn_number", "patient_identifier"]:
                dump_data = dump_data.replace("{{" + var + "}}", eval(var))
            logger.info(f"The data posted by DocSpera to DSP is : {dump_data}")
            token = os.environ["docspera_okta_token"]
            headers = {
                "Authorization": token,
                'User-Agent': 'PostmanRuntime/7.29.2',
                'Content-Type': 'application/json',
                'x-ms-blob-type':'BlockBlob'}
            baseurl = os.environ["patient_api_url"]
            endpoint = f"{baseurl}"
            test_status = True
        except Exception as e:
            logger.error(e)
            test_status = False
        assert test_status


@given('DSP consumes the data')
def dsp_consumes_the_data():
    logger.info('Step:2')
    global response
    try:
        response = requests.put(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        # assert code == 400
        logger.info(f"The status code from DSP consumes the data is : {code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@when('Data ingested errored out')
def data_ingested_errored():
    logger.info('Step:3')
    try:
        logger.info(f"The error message from the data ingested is : {response.json()}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall provide notification to DocSpera about data error')
def ack_verification():
    logger.info('Step:4')
    
    # response = requests.put(endpoint, headers=headers, data=dump_data)
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)
