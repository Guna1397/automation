*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-221

Library  RequestsLibrary
Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections
Library    ../scripts/json_import.py
Library    ../scripts/api_output_generation.py

Resource            Support_API.robot
Test Setup          Create API Output Tag List
Test Teardown       User has a Valid API Response

*** Test Cases ***
##TC01
Validate Patient details when search with MRN using MRN Search API
    [Tags]      JAYU-255
    Given Azure function is running
    And MRN Search API is available
    When Valid MRN is parsed in API
    Then 200 response code is displayed and API provides Patient FHIR resource

##TC02
Validate 0 patient count when invalid MRN is parsed in MRN Search API
    [Tags]      JAYU-256
    Given Azure function is running
    And MRN Search API is available
    When Invalid MRN is parsed in API
    Then 200 response code is displayed and API displays 0 Patient count

##TC03
Validate error message when blank MRN is parsed in MRN Search API
    [Tags]      JAYU-258
    Given Azure function is running
    And MRN Search API is available
    When Blank MRN is parsed in API
    Then 400 response code & error message is displayed


*** Keywords ***
Azure function is running
    ${parameter_list}=      param mrn search    ${env}
    Set Global Variable      ${parameter_list}
    Validate Azure Function Running

Validate Azure Function Running
    Create session   MRNSEARCH   ${parameter_list["azure_function"]["function_name"]}
    ${response}=    Get request    MRNSEARCH    /
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Pre-Requisite-Check MRN Azure Function Is Running *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  URL: ${parameter_list["azure_function"]["function_name"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response: ${response.status_code}${\n}
    ${status0}  Run Keyword And Return Status   Should be equal as strings    ${response.status_code}    200
    Run Keyword If   ${status0}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Response is Valid, Azure function is running - ${response}${\n}
    Run Keyword If  not ${status0}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Response is Invalid, Azure function is NOT running - ${response}${\n}

MRN Search API is available
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** MRN Search API Results *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   MRN Search Base URL: ${parameter_list["api_url"]["mrn_url"]}${\n}
    Create session    MRNSEARCH      ${parameter_list["api_url"]["mrn_url"]}

##TC01
Valid MRN is parsed in API
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Valid MRN: ${parameter_list["valid_params"]["mrn_id"]}${\n}
    ${parameters}=    Create Dictionary    mrn=${parameter_list["valid_params"]["mrn_id"]}
    ${response}=    get request    MRNSEARCH   /     params=${parameters}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${status1}  Run Keyword And Return Status    Should Be Equal     ${parameter_list["valid_params"]["mrn_id"]}   ${data["entry"][0]['resource']['entry'][0]['resource']['identifier'][0]['value']}
    Run Keyword If   ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The received response contains MRN - ${data["entry"][0]['resource']['entry'][0]['resource']['identifier'][0]['value']} & is same in both URL and Response${\n}
    Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The received response contains MRN - ${data["entry"][0]['resource']['entry'][0]['resource']['identifier'][0]['value']} & is NOT same in both URL and Response${\n}
    ${status2}      Run Keyword And Return Status      Should Be Equal   ${1}     ${data["entry"][0]['resource']['total']}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Resource count is ${data["entry"][0]['resource']['total']}${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Resource count is ${data["entry"][0]['resource']['total']}${\n}

200 response code is displayed and API provides Patient FHIR resource
    Should be equal as strings    200    ${r_response}


##TC02
Invalid MRN is parsed in API
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Invalid MRN: ${parameter_list["invalid_params"]["invalid_mrn"]}${\n}
    ${parameters}=    Create Dictionary    mrn=${parameter_list["invalid_params"]["invalid_mrn"]}
    ${response}=    get request    MRNSEARCH   /      params=${parameters}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${status2}      Run Keyword And Return Status      Should Be Equal   ${0}     ${data["entry"][0]['resource']['total']}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Resource count is displayed as ${data["entry"][0]['resource']['total']}${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Resource count is displayed as ${data["entry"][0]['resource']['total']}${\n}

200 response code is displayed and API displays 0 Patient count
    Should be equal as strings    200    ${r_response}


##TC03
Blank MRN is parsed in API
    Append To File  ${API_Output_filePath}${TC_ID}.txt   MRN: ${\n}
    ${parameters}=    Create Dictionary    MRN=
    ${response}=    get request    MRNSEARCH   /      params=${parameters}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${inval_data}=     Set Variable    ${response.json()}
    Log        ${inval_data["error"]}
    ${status2}  Run Keyword And Return Status       Should Be Equal  Input Parameters Should not be Blank  ${inval_data["error"]}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The error message received is same as message configured - ${inval_data["error"]}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The error message received is not same as message configured  - ${inval_data["error"]}

400 response code & error message is displayed
    Should be equal as strings    400    ${r_response}



