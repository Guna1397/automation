from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,random,uuid,time
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Data ingested successfully'

@scenario('test_ack_valid_data_injestion.feature', str(scenario_name))

def test_JAYU():
    pass


@given('DocSpera post the data to DSP')
def post_the_data_to_dsp():
        logger.info('Step:1')
        global endpoint, headers, dump_data, trans_id, patient_identifier, docspera_id, mrn_number
        try:
            with open('../test-data/JAYU-3160/ack_test_data.json') as data:
                loaded_data = json.load(data)
            dump_data = json.dumps(loaded_data)
            docspera_id = "DocsMRID" + str(random.randint(10000, 99999))
            mrn_number = "MRNID" + str(random.randint(10000, 99999))
            patient_identifier = str(uuid.uuid4())
            for var in ["docspera_id", "mrn_number", "patient_identifier"]:
                dump_data = dump_data.replace("{{" + var + "}}", eval(var))
            token = os.getenv("valid_okta_token")
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


@then('DSP consumes the data')
def dsp_consumes_the_data():
    logger.info('Step:2')
    global trans_id
    try:
        response = requests.post(endpoint, headers=headers, data=dump_data)
        logger.info(response.json())
        trans_id = response.json()["Transaction_id"]
        code = response.status_code
        assert code == 201
        logger.info(f"The status code is {code}")
        logger.info(f"The trans_id is {trans_id}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@when('Data ingested successfully within DSP')
def data_ingested_successfully():
    logger.info('Step:3')
    try:
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall provide notification to DocSpera about successful data ingestion')
def ack_verification():
    logger.info('Step:4')
    formatted_dict = {'trans_id': str(trans_id)}
    query = "SELECT ack_json FROM d4c_fhir_datastore.acknowledge where transaction_id = '{trans_id}'"
    # query = "SELECT ack_json FROM d4c_fhir_datastore.acknowledge where transaction_id = '636b9f28-b366-4c51-b38c-1913a59ec781'"
    query = query.format(**formatted_dict)
    result_data = pool_connection.fetch_all(query, None)
    logger.info(result_data)
    Ack = result_data[0]["ack_json"]
    logger.info(Ack)
    formatted_ack = json.loads(Ack)
    transaction = formatted_ack["transaction_id"]
    assert trans_id == transaction
    logger.info(f"Transaction ID received in data base is {transaction}")
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)