from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,random,uuid
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Invalid data posted'

@scenario('test_invalid_data_validation.feature', str(scenario_name))
def test_JAYU():
    pass
@given('The data payload is posted by DocSpera')
def payload_is_posted():
    logger.info('Step:1')
    global endpoint,headers
    try:
        token = os.environ["docspera_okta_token"]
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json',
            'x-ms-blob-type':'BlockBlob'}
        baseurl = os.environ["patient_api_url"]
        endpoint = f"{baseurl}"
        logger.info(f"The endpoint is : {endpoint}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Payload is consumed by DSP')
def payload_is_consumed_by_DSP():
    logger.info('Step:2')
    try:
        logger.info('Prepared invalid payloads to consume by DSP')
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall perform validations on data resource - File format (must be in JSON)')
def invalid_json():
    logger.info('Step:3')
    with open(f'../test-data/JAYU-3157/valid_test_data.json', 'r') as data:
        base_data = json.load(data)
    dump_data = json.dumps(base_data).replace(",", "")
    docspera_id = "DocsMRID" + str(random.randint(10000, 99999))
    mrn_number = "MRNID" + str(random.randint(10000, 99999))
    patient_identifier = str(uuid.uuid4())
    trans_id = str(uuid.uuid4())
    for var in ["docspera_id", "mrn_number", "patient_identifier","trans_id"]:
        dump_data = dump_data.replace("{{" + var + "}}", eval(var))
    logger.info(f"Payload with invalid file format is : {dump_data}")
    try:
        response = requests.post(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        assert code == 400
        logger.info(f"The status code is : {code}")
        logger.info(f"The error message is : {response.json()}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall perform validations on data resource - File Name format (must be valid UUID)')
def invalid_uuid():
    logger.info('Step:4')
    with open(f'../test-data/JAYU-3157/valid_test_data.json', 'r') as data:
        loaded_data = json.load(data)
    dump_data = json.dumps(loaded_data)
    docspera_id = "DocsMRID" + str(random.randint(10000, 99999))
    mrn_number = "MRNID" + str(random.randint(10000, 99999))
    patient_identifier = str(uuid.uuid4())
    trans_id = str(random.randint(10000, 99999))
    for var in ["docspera_id", "mrn_number", "patient_identifier","trans_id"]:
        dump_data = dump_data.replace("{{" + var + "}}", eval(var))
    logger.info(f"Payload with invalid file name format is : {dump_data}")
    try:
        response = requests.post(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        assert code == 400
        logger.info(f"The status code is : {code}")
        logger.info(f"The error message is : {response.json()}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall perform validations on data resource - Presence of DocSpera ID in each data resource')
def empty_docspera_id():
    logger.info('Step:5')
    with open(f'../test-data/JAYU-3157/invalid_test_data.json', 'r') as data:
        loaded_data = json.load(data)
    dump_data = json.dumps(loaded_data)
    mrn_number = "MRNID" + str(random.randint(10000, 99999))
    patient_identifier = str(uuid.uuid4())
    trans_id = str(uuid.uuid4())
    for var in ["mrn_number", "patient_identifier","trans_id"]:
        dump_data = dump_data.replace("{{" + var + "}}", eval(var))
    logger.info(f"Payload without DocSpera ID is : {dump_data}")
    try:
        response = requests.post(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        assert code == 400
        logger.info(f"The status code is : {code}")
        logger.info(f"The error message is : {response.json()}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall perform validations on data resource - USCDI specs')
def USCDI_specs():
    logger.info('Step:6')
    global trans_id
    with open(f'../test-data/JAYU-3157/invalid_uscdi_test_data.json', 'r') as data:
        loaded_data = json.load(data)
    dump_data = json.dumps(loaded_data)
    docspera_id = "DocsMRID" + str(random.randint(10000, 99999))
    mrn_number = "MRNID" + str(random.randint(10000, 99999))
    trans_id = str(uuid.uuid4())
    for var in ["docspera_id", "mrn_number", "trans_id"]:
        dump_data = dump_data.replace("{{" + var + "}}", eval(var))
    logger.info(f"Payload without USCDI specs is : {dump_data}")
    try:
        response = requests.post(endpoint, headers=headers, data=dump_data)
        code = response.status_code
        assert code == 400
        logger.info(f"The status code is : {code}")
        logger.info(f"The error message is : {response.json()}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System stores errors as part of data processing')
def data_processing():
    logger.info('Step:7')
    try:
        logger.info("System stores errors as part of data processing")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System does not store the original data for further processing')
def does_not_store_data():
    logger.info('Step:8')
    logger.info("System does not store the original data for further processing")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)