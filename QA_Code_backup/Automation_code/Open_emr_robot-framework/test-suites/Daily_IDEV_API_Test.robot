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
#    When params is parsed in DELTACHANGE API
    When params is parsed in MRN SEARCH API
#    And params is parsed in PATIENT API
#    And params is parsed in PRACTITIONER API
#    And params is parsed in ORGANIZATION API
#    Then 200 response code is displayed

*** Keywords ***
Azure function is running
    ${parameter_list}=      param_daily    ${env}
    Set Global Variable      ${parameter_list}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** API Test Results *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ${\n}

##TC01
params is parsed in PATIENT API
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Patient API Result *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Patient API Base URL: ${parameter_list["patient_base_url"]}${\n}
#    Generate JWT Token
    ${content_type_response}=     Set Variable   ${parameter_list["jwt_token"]}
    ${patient_json}=     Set Variable    ${parameter_list["patient_body"]}
    ${patient_base_url}=    Set Variable   ${parameter_list["patient_base_url"]}
    ${Bearer}   Set Variable        Bearer
#    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}    PurposeOfUse=http://terminology.hl7.org/CodeSystem/v3-ActReason|CAREMGT   UserID=1  Source=Velys    Content-Type=application/json
    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}
    Create session      patient_api         ${patient_base_url}
    ${session_status}=   Run Keyword And Return Status        Get On Session      patient_api    /${parameter_list["patient_params"]["dsep_id"]}   headers=${headers_aipee}   json=${patient_json}
    Log To Console     ${session_status}
    IF  "${session_status}" == "True"
        ${response}=        Get On Session      patient_api    /${parameter_list["patient_params"]["dsep_id"]}   headers=${headers_aipee}   json=${patient_json}
        ${data}=     Set Variable    ${response.json()}

        Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameter_list["patient_params"]["dsep_id"]}${\n}
#        Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    #    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Json: ${data}${\n}
        ${status0}   Run Keyword And Return Status    Should be equal as strings    200     ${response.status_code}
        Run Keyword If   ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Response code ${response.status_code} received${\n}
        Run Keyword If    not ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "${response.status_code}" shown${\n}
        ${status1}   Run Keyword And Return Status    Should Be Equal    ${data["entry"][0]["resource"]["id"]}      ${parameter_list["patient_params"]["dsep_id"]}
        Run Keyword If   ${status1}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : DSEP Patient id in the request and response are same - ${data["entry"][0]["resource"]["id"]}${\n}
        Run Keyword If    not ${status1}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : DSEP Patient id in the request and response are not same - ${data["entry"][0]["resource"]["id"]}${\n}
    END
    IF  "${session_status}" == "False"
        Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "403" shown${\n}
    END

params is parsed in DELTACHANGE API
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Delta Change API Result *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Delta Change API Base URL: ${parameter_list["delta_change_base_url"]}${\n}
    ${content_type_response}=     Set Variable   ${parameter_list["jwt_token"]}
    ${delta_json}=     Set Variable    ${parameter_list["delta_change_body"]}
    ${delta_change_base_url}=    Set Variable   ${parameter_list["delta_change_base_url"]}
    ${Bearer}   Set Variable        Bearer
#    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}    PurposeOfUse=http://terminology.hl7.org/CodeSystem/v3-ActReason|CAREMGT   UserID=1  Source=Velys    Content-Type=text/plain
    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}
    ${delta_parameters}=    Create Dictionary    org_id=${parameter_list["delta_params"]["org_id"]}      epoch_from=${parameter_list["delta_params"]["epoch_from"]}
    Create session      delta_change_api         ${delta_change_base_url}
    ${session_status}=   Run Keyword And Return Status        Get On Session      delta_change_api  /    params=${delta_parameters}   headers=${headers_aipee}    json=${delta_json}
    Log To Console     ${session_status}
    IF  "${session_status}" == "True"
        ${response}=        Get On Session      delta_change_api    /    params=${delta_parameters}   headers=${headers_aipee}   json=${delta_json}
        ${data}=     Set Variable    ${response.json()}
        Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${delta_parameters}${\n}
#        Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    #    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Json: ${data}${\n}
        ${status0}   Run Keyword And Return Status    Should be equal as strings    200     ${response.status_code}
        Run Keyword If   ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Response code ${response.status_code} received${\n}
        Run Keyword If    not ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "${response.status_code}" shown${\n}
        ${status1}  Run Keyword And Return Status     Should Not Be Equal   ${0}    ${data["resource_count"]}
        Run Keyword If   ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : ${data["resource_count"]} Delta Resource count is displayed ${\n}
        Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : ${data["resource_count"]} Delta Resource count is displayed ${\n}
    END
    IF  "${session_status}" == "False"
        Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "403" shown${\n}
    END

params is parsed in MRN SEARCH API
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** MRN Search API Result *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   MRN Search API Base URL: ${parameter_list["mrn_search_base_url"]}${\n}
    ${content_type_response}=     Set Variable   ${parameter_list["jwt_token"]}
    ${mrn_json}=     Set Variable    ${parameter_list["mrn_search_body"]}
    ${mrn_search_base_url}=    Set Variable   ${parameter_list["mrn_search_base_url"]}
    ${Bearer}   Set Variable        Bearer
#    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}    PurposeOfUse=http://terminology.hl7.org/CodeSystem/v3-ActReason|CAREMGT   UserID=1  Source=Velys    Content-Type=text/plain
    ${headers_aipee}=    Create Dictionary    Authorization=${Bearer} ${content_type_response}
    ${mrn_parameters}=    Create Dictionary    mrn=${parameter_list["mrn_search_params"]["mrn"]}
    Create session      mrn_search_api         ${mrn_search_base_url}
    ${session_status}=   Run Keyword And Return Status        Get On Session      mrn_search_api    /    params=${mrn_parameters}   headers=${headers_aipee}    json=${mrn_json}
    Log To Console     ${session_status}
    IF  "${session_status}" == "True"
        ${response}=        Get On Session      mrn_search_api  /    params=${mrn_parameters}   headers=${headers_aipee}    json=${mrn_json}
        ${data}=     Set Variable    ${response.json()}
        Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${mrn_parameters}${\n}
#        Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    #    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Json: ${data}${\n}
        ${status0}   Run Keyword And Return Status    Should be equal as strings    200     ${response.status_code}
        Run Keyword If   ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Response code ${response.status_code} received${\n}
        Run Keyword If    not ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "${response.status_code}" shown${\n}
        ${status1}  Run Keyword And Return Status    Should Be Equal     ${parameter_list["mrn_search_params"]["mrn"]}   ${data['resource']['entry'][0]["resource"]['identifier'][2]['value']}
        Run Keyword If   ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The received response contains MRN - ${data['resource']['entry'][0]['resource']['identifier'][2]['value']} & is same in both URL and Response${\n}
        Run Keyword If   not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The received response contains MRN - ${data['resource']['entry'][0]['resource']['identifier'][2]['value']} & is NOT same in both URL and Response${\n}
    END
    IF  "${session_status}" == "False"
        Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "403" shown${\n}
    END

params is parsed in PRACTITIONER API
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Practitioner API Result *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Practitioner API Base URL: ${parameter_list["practitioner_base_url"]}${\n}
    ${content_type_response}=     Set Variable   ${parameter_list["jwt_token"]}
    ${practitioner_json}=     Set Variable    ${parameter_list["practitioner_body"]}
    ${practitioner_base_url}=    Set Variable   ${parameter_list["practitioner_base_url"]}
    ${Bearer}   Set Variable        Bearer
#    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}    PurposeOfUse=http://terminology.hl7.org/CodeSystem/v3-ActReason|CAREMGT   UserID=1  Source=Velys    Content-Type=text/plain
    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}
    Create session      practitioner_api         ${practitioner_base_url}
    ${session_status}=   Run Keyword And Return Status        Get On Session      practitioner_api    /${parameter_list["practitioner_params"]["id"]}   headers=${headers_aipee}   json=${practitioner_json}
    Log To Console     ${session_status}
    IF  "${session_status}" == "True"
        ${response}=        Get On Session      practitioner_api    /${parameter_list["practitioner_params"]["id"]}   headers=${headers_aipee}   json=${practitioner_json}
        ${data}=     Set Variable    ${response.json()}
        Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameter_list["practitioner_params"]["id"]}${\n}
#        Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    #    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Json: ${data}${\n}
        ${status0}   Run Keyword And Return Status    Should be equal as strings    200     ${response.status_code}
        Run Keyword If   ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Response code ${response.status_code} received${\n}
        Run Keyword If    not ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "${response.status_code}" shown${\n}
        ${status1}  Run Keyword And Return Status    Should Be Equal     ${parameter_list["practitioner_params"]["id"]}   ${data["entry"][0]["resource"]["id"]}
        Run Keyword If   ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The received response contains Practitioner id - ${data["entry"][0]["resource"]["id"]} & is same in both URL and Response${\n}
        Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The received response contains Practitioner id - ${data["entry"][0]["resource"]["id"]} & is NOT same in both URL and Response${\n}
    END
    IF  "${session_status}" == "False"
        Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "403" shown${\n}
    END

params is parsed in ORGANIZATION API
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Organization API Result *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Organization API Base URL: ${parameter_list["organization_base_url"]}${\n}
    ${content_type_response}=     Set Variable   ${parameter_list["jwt_token"]}
    ${organization_json}=     Set Variable    ${parameter_list["organization_body"]}
    ${organization_base_url}=    Set Variable   ${parameter_list["organization_base_url"]}
    ${Bearer}   Set Variable        Bearer
#    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}    PurposeOfUse=http://terminology.hl7.org/CodeSystem/v3-ActReason|CAREMGT   UserID=1  Source=Velys    Content-Type=text/plain
    ${headers_aipee}=    Create Dictionary    User-Agent=PostmanRuntime/7.29.2    Authorization=${Bearer} ${content_type_response}
    Create session      organization_api         ${organization_base_url}
    ${session_status}=    Run Keyword And Return Status        Get On Session      organization_api  /${parameter_list["organization_params"]["id"]}   headers=${headers_aipee}   json=${organization_json}
    Log To Console     ${session_status}
    IF  "${session_status}" == "True"
        ${response}=        Get On Session      organization_api    /${parameter_list["organization_params"]["id"]}   headers=${headers_aipee}   json=${organization_json}
        ${data}=     Set Variable    ${response.json()}
        Append To File  ${API_Output_filePath}${TC_ID}.txt  Request Params: ${parameter_list["organization_params"]["id"]}${\n}
#        Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Status Code: ${response.status_code}${\n}
    #    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response Json: ${data}${\n}
        ${status0}   Run Keyword And Return Status    Should be equal as strings    200     ${response.status_code}
        Run Keyword If   ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Response code ${response.status_code} received${\n}
        Run Keyword If    not ${status0}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "${response.status_code}" shown${\n}
        ${status1}  Run Keyword And Return Status    Should Be Equal     ${parameter_list["organization_params"]["id"]}   ${data["entry"][0]["resource"]["id"]}
        Run Keyword If   ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : The received response contains Organization id - ${data["entry"][0]["resource"]["id"]} & is same in both URL and Response${\n}
        Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : The received response contains Organization id - ${data["entry"][0]["resource"]["id"]} & is NOT same in both URL and Response${\n}
    END
    IF  "${session_status}" == "False"
        Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Expected response code 200 not received, instead "403" shown${\n}
    END

200 response code is displayed and API provides Patient FHIR resource
    Should be equal as strings    200    ${r_response}

Generate JWT Token
    ${headers}=    Create Dictionary    client_id=${parameter_list["jwt_client_id"]}  client_secret=${parameter_list["jwt_client_secret"]}
    Create session  GENERATE_JWT  ${parameter_list["jwt_url"]}
    ${resp}=    Get On Session   GENERATE_JWT  /    headers=${headers}
    ${status_jwt}  Run Keyword And Return Status   Status Should Be    OK    ${resp}
    Run Keyword If  not ${status_jwt}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL :  JWT Token Not Generated${\n}
    ${content_type_response}=    Get From Dictionary    ${resp.headers}    jwt-token
    Set Global Variable  ${content_type_response}
    Log To Console    ${content_type_response}




