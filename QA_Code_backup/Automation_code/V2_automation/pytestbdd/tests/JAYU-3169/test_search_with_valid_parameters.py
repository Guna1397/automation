from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests
from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

scenario_name = 'Search with valid parameters'

@scenario('test_search_with_valid_parameters.feature', str(scenario_name))
def test_JAYU_3169():
    pass
@given('User wants to retrieve Practitioner details using Practitioner API')
def prepare_autherization_token():
    logger.info('Step:1')
    global token

    try:
        baseurl = os.environ["practitioner_api_url"]
        logger.info(f"Practitioner API URL used to retrieve Practitioner details is : {baseurl}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('API call is made using (Valid NPI, Valid DSP ID, First Name, Last Name) search parameters')
def send_an_api_request():
    logger.info('Step:2')
    global response_data1,response_data2,response_data3,response_data4,response1, response2,response3,response4

    #### checking with dsep_pactitioner ####
    try:
        token = os.getenv("velys_okta_token")   
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.32.2',
            'Content-Type': 'application/json'}
        json_data = {}
        baseurl = os.environ["practitioner_api_url"]
        valid_ID1 = os.environ["prac_valid_dsp_id"]
        endpoint1 = f"{baseurl}/{valid_ID1}"
        logger.info(f" Practitioner API URL using valid DSP ID : {endpoint1}\n")
        response1 = requests.get(endpoint1, headers=headers, data=json.dumps(json_data))
        response_data1 = response1.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

    #### checking with npi ####
    try:
        valid_ID2 = os.environ["valid_npi_id"]
        endpoint2 = f"{baseurl}/id-key/npi/id-value/{valid_ID2}"
        logger.info(f" Practitioner API URL using Valid NPI : {endpoint2}\n")
        response2 = requests.get(endpoint2, headers=headers, data=json.dumps(json_data))
        response_data2 = response2.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

     #### checking with firstname ####
    try:
        valid_ID3 = os.environ["prac_valid_fname"]
        endpoint3 = f"{baseurl}/id-key/first_name/id-value/{valid_ID3}"
        logger.info(f" Practitioner API URL using Valid first name : {endpoint3}\n")
        response3 = requests.get(endpoint3, headers=headers, data=json.dumps(json_data))
        response_data3 = response3.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

     #### checking with lastname ####
    try:
        valid_ID4 = os.environ["prac_valid_lname"]
        endpoint4 = f"{baseurl}/id-key/last_name/id-value/{valid_ID4}"
        logger.info(f" Practitioner API URL using Valid last name : {endpoint4}\n")
        response4 = requests.get(endpoint2, headers=headers, data=json.dumps(json_data))
        response_data4 = response4.json()
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('API gives 200 response code')
def verify_response_code():
    logger.info("Step:3")
    expected_status_code = 200
    try:
        assert expected_status_code == response1.status_code
        logger.info(f"The response code from the response for valid DSP ID is : {response1.status_code}\n")
        assert expected_status_code == response2.status_code
        logger.info(f"The response code from the response for valid NPI is : {response2.status_code}\n")
        assert expected_status_code == response3.status_code
        logger.info(f"The response code from the response for valid practitioner first name is : {response3.status_code}\n")
        assert expected_status_code == response4.status_code
        logger.info(f"The response code from the response for valid practitioner last name is : {response4.status_code}\n")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status


@then('Practitioner details with matching record is provided to user')
def verify_response_data():
    logger.info("Step:3")
    logger.info(f'Response message for valid DSP ID is : {response_data1}\n')
    logger.info(f'Response message for valid NPI is : {response_data2}\n')
    logger.info(f'Response message for valid NPI is : {response_data3}\n')
    logger.info(f'Response message for valid NPI is : {response_data4}\n')
    evidence = "evidence"
    create_json.createjson(scenario_name,evidence)
