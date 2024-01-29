import uuid
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,random,requests
from test.pytestbdd.tests import create_json
# from dbhelper import SqlPooled
#
# pool_connection = SqlPooled()

with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'DocSpera_Velys - S3 export_naming format of DSP ID/Transaction ID'

@scenario('S3_export_naming_format_change.feature', str(scenario_name))
def test_JAYU():
    pass


@given('User has patient data that needs to be onboarded')
def patient_data_onboard():
    logger.info('Step:1')
    global dump_data,baseurl,headers
    try:
        with open('../test-data/JAYU-2131/resource_test_data_velys.json') as data:
            loaded_data = json.load(data)
        dump_data = json.dumps(loaded_data)
        mrn_number = "MRNID" + str(random.randint(10000, 99999))
        for var in ["mrn_number"]:
            dump_data = dump_data.replace("{{" + var + "}}", eval(var))
        token = os.environ["velys_okta_token"]
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json',
            'x-ms-blob-type': 'BlockBlob'}
        baseurl = os.environ["patient_api_url"]
        logger.info(f"Patient data payload that needs to be onboarded is : {dump_data}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Patient data is onboarded via Velys application (Non EMR workflow)')
def send_patient_data_via_velys():
    logger.info('Step:2')
    global response,result_data
    try:
        response = requests.post(baseurl, headers=headers, data=dump_data)
        result_data = response.json()
        logger.info(result_data)
        logger.info(f"Patient API URL to onboard the patient data is : {baseurl}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('Patient data should be stored within DSP')
def verify_data_stored_in_dsp():
    logger.info("Step:3")
    global trans_id
    try:
        assert result_data["entry"][0]["response"]["status"] == "201 Created"
        logger.info(f'The status from the response : {result_data["entry"][0]["response"]["status"]}')
        trans_id = result_data["id"]
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status
    
@then('Patient Data is moved to DocSpera S3 container with transaction ID in below format "{dsep_d4c_patient_id}/{uuid}.json"')
def verify_file_name_format():
    logger.info("Step:4")
    # formatted_dict = {'trans_id': str(trans_id)}
    # query = "SELECT s3_file_name FROM d4c_fhir_datastore.s3_update where transaction_id = '{trans_id}'"
    # query = query.format(**formatted_dict)
    # query = "SELECT s3_file_name FROM d4c_fhir_datastore.s3_update where transaction_id = '9edd8f62-ab60-42cb-b3eb-f1587c0c7658'"
    # result_data = pool_connection.fetch_all(query, None)
    # logger.info(f'The filename from the response : {result_data[0]["s3_file_name"]}')
    baseurl = os.environ["hcp_url"]
    endpoint = f"{baseurl}'/'{trans_id}"
    get_response = requests.get(endpoint, headers=headers, data=None)
    get_result = get_response.json()
    logger.info(f"Patient Data is moved to DocSpera S3 container with the transaction ID format is : {get_result}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)