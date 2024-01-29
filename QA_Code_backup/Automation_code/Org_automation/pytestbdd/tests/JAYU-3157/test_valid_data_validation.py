from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,random,uuid
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Valid data posted'

@scenario('test_valid_data_validation.feature', str(scenario_name))

def test_JAYU():
    pass

@given('The data payload is posted by DocSpera')
def post_the_data_to_dsp():
        logger.info('Step:1')
        global endpoint, headers, dump_data, trans_id, patient_identifier, docspera_id, mrn_number
        try:
            with open('../test-data/JAYU-3157/valid_test_data.json') as data:
                loaded_data = json.load(data)
            dump_data = json.dumps(loaded_data)
            docspera_id = "DocsMRID" + str(random.randint(10000, 99999))
            mrn_number = "MRNID" + str(random.randint(10000, 99999))
            patient_identifier = str(uuid.uuid4())
            trans_id = str(uuid.uuid4())
            for var in ["docspera_id", "mrn_number", "patient_identifier","trans_id"]:
                dump_data = dump_data.replace("{{" + var + "}}", eval(var))
            logger.info(f"Payload with valid details is : {dump_data}")
            token = os.environ["docspera_okta_token"]
            headers = {
                "Authorization": token,
                'User-Agent': 'PostmanRuntime/7.29.2',
                'Content-Type': 'application/json',
                'x-ms-blob-type': 'BlockBlob'}
            baseurl = os.environ["patient_api_url"]
            endpoint = f"{baseurl}"
            logger.info(f"The endpoint is : {endpoint}")
            test_status = True
        except Exception as e:
            logger.error(e)
            test_status = False
        assert test_status


@when('Payload is consumed by DSP')
def dsp_consumes_the_data():
    logger.info('Step:2')
    global response
    try:
        response = requests.post(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        assert code == 201
        logger.info(f"The status code is : {code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('System shall perform below validations (File format (must be in JSON), File Name format must be valid UUID, Presence of DocSpera ID in each data resource, USCDI specs) on data resource')
def data_ingested_successfully():
    logger.info('Step:3')
    try:
        logger.info(f"The Response message is : {response.json()}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System stores the data for further processing')
def ack_verification():
    logger.info('Step:4')
    logger.info('System stores the data for further processing')
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)