import pytest
from pytest_bdd import given, then, when, scenario
from custom_logger import logger
import os,json,requests,uuid

from test.pytestbdd.tests import create_json

# load config json
with open('config.json') as file:
    localSettings = json.load(file)

for i in localSettings['data']:
    os.environ[i] = localSettings['data'][i]

local_path = '../test-data/test_create_org_with_one_contract/'

scenario_name = "User wants to associate Org to one contract"
@scenario('test_create_org_with_one_contract.feature', str(scenario_name))
def test_create_org_with_one_contract():
    pass

@given('User has org to be onboarded to DSP')
def prepare_authorization_token():
    logger.info('Step:1')
    global token,json_data
    try:
        with open(local_path+"create_with_contract_details.json", 'r') as data:
            base_data = json.load(data)
        base_json = json.dumps(base_data)
        id = str(uuid.uuid4())
        string_data=base_json.replace("{uuid}", id)
        json_data = json.loads(string_data)
        logger.info(f"Payload for org to be onboarded to DSP is : {json_data}")
        token = os.environ["valid_okta_token"]
        # print(token)
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('User makes call to Org API to onboard the organization')
def prepare_for_org_payload():
    logger.info('Step:2')
    global json_data, id
    try:
        logger.info(f"Org API url to onboard the organization is : {os.environ['org_api_url']}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('User specifies (Contract ID,Contract Owner,Contract Effective Date,Contract Termination Date,Permitted Primary Use Categories,Secondary Use Flag,Permitted Secondary Use Categories,Data Classification Type,Permitted Geography,Franchise,Application or Device,Incident / Breach Notification SLA) mandatory fields as part of onboarding request')
def verify_basic_information():
    logger.info('Step:3')
    try:
        logger.info(f"Mandatory fields specified in onboarding request is : {json_data['contract']}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@when('Contract termination date is not <= current date')
def send_an_api_request():
    logger.info('Step:4')
    global result_data,response_code,result
    try:
        headers = {
            "Authorization": token,
            'User-Agent': 'PostmanRuntime/7.29.2',
            'Content-Type': 'application/json'}
        base_url = f'{os.environ["org_api_url"]}'
        response = requests.post(base_url,headers=headers, data=json.dumps(json_data))
        result_data = response.json()
        # logger.info(result_data)
        result = result_data["message"]
        logger.info(f"Contract termination date from the payload is '{json_data['contract'][0]['Contract_Termination_Date']}' which is not <= current date")
        # print(result)
        response_code = response.status_code
        logger.info(f"The status code from the response is {response_code}")
        test_status = True
    except Exception as e:
        logger.error(e)
        test_status = False
    assert test_status

@then('System shall store user specified contract information along with other Org details')
def verify_success_response():
    logger.info('Step:5')
    assert result == "Successfully created organization"
    logger.info(f"The response for 'User wants to associate Org to one contract' is : {result}")
    evidence = "evidence"
    create_json.createjson(scenario_name, evidence)