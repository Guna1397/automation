*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-220

Library  RequestsLibrary
Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections
Library  DateTime
Library    ../scripts/json_import.py
Library    ../scripts/api_output_generation.py


Resource            Support_API.robot

Suite Setup         Remove Output files
Test Setup          Create API Output Tag List
Test Teardown       User has a Valid API Response

*** Test Cases ***
## TC01
Validate resources details when valid Organization ID & valid EPCOH From date is passed in Delta update API
    [Tags]      JAYU-234
    Given Azure function is running
    And Velys Delta Update API is available
    When Valid Organization ID and epoch from date is parsed in API
    Then 200 response code is displayed and API provides the details of resources

## TC02
Validate error message when blank epoch from and blank Org ID is parsed in Delta update API
    [Tags]      JAYU-244
    Given Azure function is running
    And Velys Delta Update API is available
    When Blank Organization ID and Blank epoch from date is parsed in API
    Then 400 response code & error message is displayed

## TC03
Validate error message when invalid epoch from is parsed in the Delta update API
    [Tags]      JAYU-245
    Given Azure function is running
    And Velys Delta Update API is available
    When Valid Organization ID and Non-numeric epoch from date is parsed in API
    Then 400 response code & error message is displayed
    When Valid Organization ID and Future epoch from date is parsed in API
    Then 400 response code & error message is displayed

## TC04
Validate 0 resource count is displayed when invalid Organization ID is parsed in Delta update API
    [Tags]      JAYU-246
    Given Azure function is running
    And Velys Delta Update API is available
    When Invalid Organization ID and valid epoch from date is parsed in API
    Then 200 response code is displayed and API displayes 0 resource count

*** Keywords ***
##first level keywords
Azure function is running
    ${parameter_list}=      param delta update    ${env}
    Set Global Variable      ${parameter_list}
    Validate Azure Function Running

## Second level keywords
Validate Azure Function Running
    Create session   VELYSDELTACHANGE   ${parameter_list["azure_function"]["function_name"]}
    #${response} = requests.get("VELYSDELTACHANGE", verify=False)
    ${response}=    Get request    VELYSDELTACHANGE    /
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Pre-Requisite - Azure Function Is Running *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  URL: ${parameter_list["azure_function"]["function_name"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response: ${response.status_code}${\n}
    ${status0}  Run Keyword And Return Status   Should be equal as strings    ${response.status_code}    200
    Run Keyword If   ${status0}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Response is Valid, Azure function is Running ${\n}
    Run Keyword If  not ${status0}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Response is Invalid, Azure function is NOT Running ${\n}

Velys Delta Update API is available
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Delta Update API *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Velys Delta Update Base URL: ${parameter_list["delta_update_url_params"]["velys_url"]}${\n}
    Create session    VELYSDELTACHANGE      ${parameter_list["delta_update_url_params"]["velys_url"]}

## TC01
Valid Organization ID and epoch from date is parsed in API
    Append To File  ${API_Output_filePath}${TC_ID}.txt   OrgId: ${parameter_list["valid_params"]["org_id"]}${\n}
    ${epoch}=  epoch_converter  ${parameter_list["valid_params"]["epoch_from"]}
    Log     ${epoch}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Epoch From: ${parameter_list["valid_params"]["epoch_from"]}\[${epoch}]${\n}
    ${parameters}=    Create Dictionary    epoch_from=${parameter_list["valid_params"]["epoch_from"]}    org_id=${parameter_list["valid_params"]["org_id"]}
    ${response}=    Post request    VELYSDELTACHANGE   /      params=${parameters}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${status1}  Run Keyword And Return Status     Should Not Be Equal   ${0}    ${data["resource_count"]}
    Run Keyword If   ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : ${data["resource_count"]} Delta Resource count is displayed ${\n}
    Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : ${data["resource_count"]} Delta Resource count is displayed ${\n}

200 response code is displayed and API provides the details of resources
    Should be equal as strings    200    ${r_response}

## TC02
Invalid Organization ID and valid epoch from date is parsed in API
    Append To File  ${API_Output_filePath}${TC_ID}.txt   OrgId: ${parameter_list["invalid_params"]["invalid_orgid"]}${\n}
    ${epoch}=  epoch_converter  ${parameter_list["valid_params"]["epoch_from"]}
    Log     ${epoch}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Epoch From: ${parameter_list["valid_params"]["epoch_from"]} \ Date in Readable format: [${epoch}]${\n}
    ${parameters}=    Create Dictionary    epoch_from=${parameter_list["valid_params"]["epoch_from"]}    org_id=${parameter_list["invalid_params"]["invalid_orgid"]}
    ${response}=    Post request    VELYSDELTACHANGE   /      params=${parameters}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${status2}  Run Keyword And Return Status       Should Be Equal   ${0}    ${data["resource_count"]}${\n}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : ${data["resource_count"]} Delta Resource Count is displayed${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : ${data["resource_count"]} Delta Resource Count is displayed as Invalid OID is parsed${\n}

200 response code is displayed and API displayes 0 resource count
    Should be equal as strings    200    ${r_response}

## TC03
Valid Organization ID and Non-numeric epoch from date is parsed in API
    Append To File  ${API_Output_filePath}${TC_ID}.txt   **** When Epoch From is Non-Numeric **** ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   OrgId: ${parameter_list["valid_params"]["org_id"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Epoch From: ${parameter_list["invalid_params"]["non-numeric_epoch"]}${\n}
    ${parameters}=    Create Dictionary    epoch_from=${parameter_list["invalid_params"]["non-numeric_epoch"]}    org_id=${parameter_list["valid_params"]["org_id"]}
    ${response}=    Post request    VELYSDELTACHANGE   /      params=${parameters}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    Should be equal as strings    ${response.status_code}    400
    ${status2}  Run Keyword And Return Status       Should Be Equal   Epoch from doesn't allow future time and non-numeric value    ${data["error"]}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The error message received is same as message configured - ${data["error"]}${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : PASS : The error message received is not same as message configured - ${data["error"]}${\n}

400 response code & error message is displayed
    Should be equal as strings    400    ${r_response}

Valid Organization ID and Future epoch from date is parsed in API
    Append To File  ${API_Output_filePath}${TC_ID}.txt   **** When Epoch From is in Future **** ${\n}
    ${epoch}=  epoch_converter  ${parameter_list["invalid_params"]["future_epoch"]}
    Log     ${epoch}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   OrgId: ${parameter_list["valid_params"]["org_id"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Epoch From: ${parameter_list["invalid_params"]["future_epoch"]} \ Date in Readable format: [${epoch}]${\n}
    ${parameters}=    Create Dictionary    epoch_from=${parameter_list["invalid_params"]["future_epoch"]}    org_id=${parameter_list["valid_params"]["org_id"]}
    ${response}=    Post request    VELYSDELTACHANGE   /      params=${parameters}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    Should be equal as strings    ${response.status_code}    400
    ${status2}  Run Keyword And Return Status       Should Be Equal   Epoch from doesn't allow future time and non-numeric value    ${data["error"]}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The error message received is same as message configured - ${data["error"]}${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : PASS : The error message received is not same as message configured - ${data["error"]}${\n}


## TC04
Blank Organization ID and Blank epoch from date is parsed in API
    Append To File  ${API_Output_filePath}${TC_ID}.txt   OrgId: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Epoch From: ${\n}
    ${parameters}=    Create Dictionary    epoch_from=    org_id=
    ${response}=    Post request    VELYSDELTACHANGE   /      params=${parameters}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${status2}  Run Keyword And Return Status       Should Be Equal   Input Parameters Should not be Blank    ${data["error"]}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The error message received is same as message configured - ${data["error"]}${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The error message received is NOT same as message configured  - ${data["error"]}${\n}

