*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-222

Library     String
Library  RequestsLibrary
Library    ../scripts/json_import.py
Library    ../scripts/api_output_generation.py
#Library  partner-sync-func.py
Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections

Resource            Support_API.robot
Test Setup          Create API Output Tag List
Test Teardown       User has a Valid API Response

*** Variables ***
${env}

*** Test Cases ***
## TC01
Validate Patient details exported using S3 Update API
    [Tags]      JAYU-248
    Given Azure function is running
    And S3 Update api is available
    When Valid resource type and id is parsed in api
    Then 200 response code is displayed and API provides the details of patient resources

## TC02
Validate error message when invalid ID is parsed in the S3 Update API
    [Tags]      JAYU-249
    Given Azure function is running
    And S3 Update api is available
    When Invalid id and valid resource type is parsed in api
    Then 400 response code & error message is displayed

## TC03
Validate error message when invalid resource type is parsed in the S3 Update API
    [Tags]      JAYU-250
    Given Azure function is running
    And S3 Update api is available
    When Invalid resource type and valid id is parsed in api
    Then 400 response code & error message is displayed

## TC04
Validate error message when blank resource type and blank id is parsed in the S3 Update API
    [Tags]      JAYU-251
    Given Azure function is running
    And S3 Update api is available
    When Blank resource type and blank id is parsed in api
    Then 400 response code & error message is displayed

*** Keywords ***
Azure function is running
    ${parameter_list}=      param_partner_sync    ${env}
    Set Global Variable      ${parameter_list}
    Validate Azure Function Running

Validate Azure Function Running
    Create session   S3PARTNERSYNC   ${parameter_list["non_apigee_root_url_params"]["partner-sync_url"]}
    ${response}=    Get request    S3PARTNERSYNC    /
    ${status0}  Run Keyword And Return Status   Should be equal as strings    ${response.status_code}    200
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Pre-Requisite-Check S3 Update API Is Running *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  URL: ${parameter_list["non_apigee_root_url_params"]["partner-sync_url"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response: ${response.status_code}${\n}
    Run Keyword If   ${status0}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Azure function is running - ${response}${\n}
    Run Keyword If  not ${status0}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Azure function is NOT running - ${response}${\n}

S3 Update api is available
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** S3 Update API *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   S3 Update Base URL: ${parameter_list["non_apigee_api_url_params"]["partner-sync_url"]}${\n}
    Create session    S3PARTNERSYNC      ${parameter_list["non_apigee_api_url_params"]["partner-sync_url"]}

Valid resource type and id is parsed in api
    #${json}=    jsoner    ${env}
    ${json}=      Set Variable      ${parameter_list["S3_input"]}
    Log  ${json["identifier"][0]["system"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource Type: ${parameter_list["valid_params"]["partner-sync_resource_type"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   ID: ${parameter_list["valid_params"]["partner-sync_id"]}${\n}
    ${parameters}=    Create Dictionary    resource_type=${parameter_list["valid_params"]["partner-sync_resource_type"]}    id=${parameter_list["valid_params"]["partner-sync_id"]}
    ${response}=    Post request    S3PARTNERSYNC   /${parameter_list["valid_params"]["partner-sync_resource_type"]}/${parameter_list["valid_params"]["partner-sync_id"]}    json=${json}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
     ${dsep_id}=       s3_check_dsep_uuid     ${response.json()}
     Log    ${dsep_id}
     Log    ${json["identifier"][0]["system"]}
     ${status_param1}  Run Keyword And Return Status    Should Not Be Equal   None     ${dsep_id}
     Run Keyword If   ${status_param1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : DSEP Patient ID present in response is valid - ${dsep_id}${\n}
     Run Keyword If  not ${status_param1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL :  DSEP Patient ID present in response is invalid  - ${dsep_id}${\n}
     ${oid}=       s3_check_oid     ${response.json()}
     Log    ${json["identifier"][0]["system"]}
     ${status3}  Run Keyword And Return Status      Should Be Equal        ${json["resourceType"]}    ${data["resourceType"]}
     Run Keyword If   ${status3}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Resource Type in request and response are same - ${data["resourceType"]}${\n}
     Run Keyword If  not ${status3}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Resource Type in request and response are not same - ${data["resourceType"]}${\n}
     ${status4}  Run Keyword And Return Status      Should Be Equal        ${parameter_list["valid_params"]["partner-sync_id"]}   ${data["id"]}
     Run Keyword If   ${status4}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : ID in request and response are same - ${data["id"]}${\n}
     Run Keyword If  not ${status4}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : ID in request and response are not same - ${data["id"]}${\n}
     ${status_1}  Run Keyword And Return Status  check_list  ${parameter_list["s3-params"]["EXTERNAL_CONNECTION_STRING"]}  ${parameter_list["s3-params"]["s3_blob"]}      ${dsep_id}
     Log to console   ${status_1}
     Run Keyword If   ${status_1}    Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : File with DSEP ID ${dsep_id} is present in the ${parameter_list["s3-params"]["s3_blob"]} container of ${parameter_list["s3-params"]["EXTERNAL_STORAGE_ACCOUNT_NAME"]} storage account${\n}
     Run Keyword If  not ${status_1}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : File with DSEP ID ${dsep_id} is not present in the ${parameter_list["s3-params"]["s3_blob"]} container of ${parameter_list["s3-params"]["EXTERNAL_STORAGE_ACCOUNT_NAME"]} storage account${\n}

     ${assigner}=       check_dsep_val      ${response.json()}
     Log To Console      ${assigner}

200 response code is displayed and API provides the details of patient resources
    Should be equal as strings    200    ${r_response}

Invalid id and valid resource type is parsed in api
    #${json}=    jsoner    ${env}
    ${json}=      Set Variable      ${parameter_list["S3_input"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource Type: ${parameter_list["valid_params"]["partner-sync_resource_type"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   ID: ${parameter_list["invalid_params"]["invalid_partner-sync_id"]}${\n}
    ${parameters}=    Create Dictionary    resource_type=${parameter_list["valid_params"]["partner-sync_resource_type"]}    id=${parameter_list["invalid_params"]["invalid_partner-sync_id"]}
    ${response}=    Post request    S3PARTNERSYNC   /${parameter_list["valid_params"]["partner-sync_resource_type"]}/${parameter_list["invalid_params"]["invalid_partner-sync_id"]}    json=${json}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${inval_data}=     Set Variable    ${response.json()}
    Log        ${inval_data["error"]}
    ${status2}  Run Keyword And Return Status       Should Be Equal  ResourceType, ResourceID is invalid  ${inval_data["error"]}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The error message received is same as message configured - ${inval_data["error"]}${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The error message received is not same as message configured - ${inval_data["error"]}${\n}

400 response code & error message is displayed
    Should be equal as strings    400    ${r_response}

Invalid resource type and valid id is parsed in api
    #${json}=    jsoner    ${env}
    ${json}=      Set Variable      ${parameter_list["S3_input"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource Type: ${parameter_list["invalid_params"]["invalid_partner-sync_resource_type"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   ID: ${parameter_list["valid_params"]["partner-sync_id"]}${\n}
    ${parameters}=    Create Dictionary    resource_type=${parameter_list["invalid_params"]["invalid_partner-sync_resource_type"]}    id=${parameter_list["valid_params"]["partner-sync_id"]}
    ${response}=    Post request    S3PARTNERSYNC   /${parameter_list["invalid_params"]["invalid_partner-sync_resource_type"]}/${parameter_list["valid_params"]["partner-sync_id"]}    json=${json}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${inval_data}=     Set Variable    ${response.json()}
    Log        ${inval_data["error"]}
    ${status2}  Run Keyword And Return Status       Should Be Equal  ResourceType, ResourceID is invalid   ${inval_data["error"]}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The error message received is same as message configured - ${inval_data["error"]}${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The error message received is not same as message configured - ${inval_data["error"]}${\n}

Blank resource type and blank id is parsed in api
    #${json}=    jsoner    ${env}
    ${json}=      Set Variable      ${parameter_list["S3_input"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource Type: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   ID: ${\n}
    ${parameters}=    Create Dictionary    resource_type=    id=
    ${response}=    Post request    S3PARTNERSYNC   /      params=${parameters}    json=${json}
    set global variable     ${r_response}     ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameters}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Body: ${response.content}${\n}
    ${inval_data}=     Set Variable    ${response.json()}
    Log        ${inval_data["error"]}
    ${status2}  Run Keyword And Return Status       Should Be Equal   Input Parameters Should not be Blank    ${inval_data["error"]}
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The error message received is same as message configured - ${inval_data["error"]}${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The error message received is not same as message configured - ${inval_data["error"]}${\n}
