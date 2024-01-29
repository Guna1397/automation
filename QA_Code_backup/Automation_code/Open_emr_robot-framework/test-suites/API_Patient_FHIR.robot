*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-242

Library  RequestsLibrary
Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections
Library    ../scripts/json_import.py
Library    ../scripts/api_output_generation.py


Resource        Variables.robot
Resource        Locators.robot
Resource        CommonKeywords.robot
Resource        Support_API.robot


Suite Setup         Remove Output files
Test Setup          Create API Output Tag List
Test Teardown       Run Keywords   User has a Valid API Response   Close All Browsers

*** Variables ***
${DocsperaFile1}=    9f801853-50ee-4195-9396-a39b6cc31956
${DownloadDir}=  ${CURDIR}/downloads_robot/

${dsep_id}
${ID}
${workDir}

${Legacy_ID}
${DSEP_PID}
*** Test Cases ***
##TC01
#Validate Patient details are fetched when Patient ID present in Velys Storage Account is parsed in FHIR patient API
#    [Tags]      JAYU-299
#    Given Patient details from DocSpera is present in Velys container
#    And Azure Function is Running
#    And Velys Patient FHIR API is available
#    When Valid DSP Patient ID is parsed in API
#    Then 200 response code is displayed and API provides resources details for the patient from ADLs
#
###TC02
#Validate Patient details are fetched from legacy system when patient ID NOT present in Velys SA is parsed in FHIR patient API
#    [Tags]      JAYU-300
#    Given Patient details are not present in Velys container
#    And Azure Function is Running
#    And Velys Patient FHIR API is available
#    When Valid legacy patient identifier is parsed in API
#    Then 200 response code is displayed and API provides resources details for the patient from Legacy
#
###TC03
#Validate error message when invalid patient ID is parsed in FHIR patient API
#    [Tags]      JAYU-301
#    Given Azure Function is Running
#    And Velys Patient FHIR API is available
#    When Invalid DSP Patient id is parsed in api
#    Then 400 response code & error message is displayed
#
###TC04
#Validate details of patient resource for given patient id and resource identifier in FHIR patient API
#    [Tags]      JAYU-304
#    Given Patient details for resource from DocSpera is present in Velys container
#    And Azure Function is Running
#    And Velys Patient FHIR API is available
#    When Valid DSP Patient id and resource identifier is parsed in API
#    Then 200 response code is displayed and API provides resources details for the patient

##TC05
Validate error message when invalid resource type and invalid resource ID is parsed in FHIR patient API
    [Tags]      JAYU-305
    Given Patient details from DocSpera is present in Velys container
    And Azure Function is Running
    And Velys Patient FHIR API is available
    When Invalid Resource type and invalid resource identifier is parsed in api
    Then 400 response code & error message is displayed

###TC06
#Validate all Patient details are retrieved when Blank Patient ID is parsed in FHIR patient API
#    [Tags]      JAYU-348
#    Given Azure Function is Running
#    And Velys Patient FHIR API is available
#    When Blank DSEP Patient id is parsed in api
#    Then 200 response code is displayed and API provides resources details for all patients

*** Keywords ***
Initialize Docspera Variables
    ${json}  Get file  ${basejsonfilepath}docspera-storage-accounts_RobotTest.json
    ${DS}  Evaluate  json.loads('''${json}''')  json
    set Global Variable  ${DocsperaSA}  ${DS}
    set Global Variable   ${DSA}    ${DocsperaSA[2]["name"]}
    set Global Variable   ${VSA}    ${DocsperaSA[1]["name"]}
    Azure function is running1
    Set Global Variable   ${Legacy_ID}     ${parameter_list["valid_params"]["legacy_Patient_id"]}

Azure function is running
    ${parameter_list}=    fhir param jsoner     ${env}
    Set Global Variable      ${parameter_list}
    Validate Azure Function Running

Azure function is running1
    ${parameter_list}=    fhir param jsoner     ${env}
    Set Global Variable      ${parameter_list}
    Validate Azure Function Running1

## Second level keywords
Validate Azure Function Running
    Create session   PATIENTFHIRAPI   ${parameter_list["azure_function"]["function_name"]}
    ${response}=    Get request    PATIENTFHIRAPI    /
    ${status0}  Run Keyword And Return Status   Should be equal as strings    ${response.status_code}    200
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Pre-Requisite - Azure Function Is Running *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Azure Function URL: ${parameter_list["azure_function"]["function_name"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Response: ${response.status_code}${\n}
    Run Keyword If   ${status0}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req PASS : Response is Valid, Azure function is Running ${\n}
    Run Keyword If  not ${status0}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req FAIL : Response is Invalid, Azure function is NOT Running ${\n}

Validate Azure Function Running1
    Create session   PATIENTFHIRAPI   ${parameter_list["azure_function"]["function_name"]}
    ${response}=    Get request    PATIENTFHIRAPI    /
    ${status0}  Run Keyword And Return Status   Should be equal as strings    ${response.status_code}    200


Patient details from DocSpera is present in Velys container
    Initialize Docspera Variables
    User is logged into Azure & user has required Subscription
    User uploads a file in blob container of Docspera storage account  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}
    User Validate File has been acknowledged in Velys container  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][3]}    ${VSA}
    Navigate to Docspera Storage account Blob container    ${VSA}
    Navigate to Patient Directory     ${docsperaSA[3]["container"][0]}    ${DSEP_PID}

Patient details for resource from DocSpera is present in Velys container
    Initialize Docspera Variables
    User is logged into Azure & user has required Subscription
    User uploads a file in blob container of Docspera storage account  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}
    User Validate File has been acknowledged in Velys container  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][3]}    ${VSA}
    Navigate to Docspera Storage account Blob container    ${VSA}
    Navigate to file resource Directory     ${docsperaSA[3]["container"][0]}    ${DSEP_PID}

Velys Patient FHIR API is available
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** FHIR Patient API Results *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   FHIR Patient API Base URL: ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${\n}
    Create session    PATIENTFHIRAPI      ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}

Valid DSP Patient ID is parsed in API
    ${parameter_list}=    fhir param jsoner     ${env}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   DSP_Patient_ID: ${DSEP_PID}${\n}
    ${req_body}=   Set Variable    ${parameter_list["allresource_json"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    Log        The Requested Data Is : ${req_body}
    Set Global Variable      ${parameter_list}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${DSEP_PID}}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Request Body is {\n} : ${req_body}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${DSEP_PID}
    ${response}=    Get On Session   GENERATE_FHIR     /   json=${req_body}
    Status Should Be    OK    ${response}
    Set Global Variable   ${r_response}   ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    ${length}=  Get length         ${data["entry"]}
    Log To Console     ${length}
    ${status}   Run Keyword And Return Status    Should Be Equal    ${data["entry"][0]["resource"]["identifier"][1]["value"]}      ${parameter_list["valid_params"]["DSEP_Patient_Id"]}
    Log to console   ${status}
    Log to console  ${data["entry"][0]["resource"]["identifier"][1]["value"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Details :: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Code is : ${r_response}${\n}
    Run Keyword If   ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : DSEP Patient id in the request and response are same - ${data["entry"][0]["resource"]["identifier"][1]["value"]}${\n}
    Run Keyword If    not ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : DSEP Patient id in the request and response are not same - ${data["entry"][0]["resource"]["identifier"][1]["value"]}${\n}
    FOR    ${entity}    IN    @{resource_body[0]}
        ${resoruce_type}=   fhir_resource_comaprision   ${data}    ${entity}
        ${status1}  Run Keyword And Return Status      Should Be Equal         ${entity}       ${resoruce_type}
        Run Keyword If   ${status1}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : The Resource Type obtained in the response - ${resoruce_type}${\n}
        Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : The Resource Type not obtained in the response - ${resoruce_type}${\n}
    END
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${data}${\n}

## TC02
Patient details are not present in Velys container
    Initialize Docspera Variables
    Patient details are not present in dsep container of Velys storage account    ${docsperaSA[3]["container"][0]}  ${Legacy_ID}      ${VSA}

Patient details are not present in dsep container of Velys storage account
    [Arguments]  ${docsperaSA[3]["container"][0]}  ${Legacy_ID}      ${VSA}
    User is logged into Azure & user has required Subscription
    Validate in Velys SA that Patient is NOT present in dsep container  ${docsperaSA[3]["container"][0]}  ${Legacy_ID}      ${VSA}

Validate in Velys SA that Patient is NOT present in dsep container
    [Arguments]  ${container_name}  ${DocsperaFile1}    ${sa_name}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    File Should Not be Present in dsp container  ${container_name}  ${DocsperaFile1}

File Should Not be Present in dsp container
    [Arguments]  ${container}  ${filename}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Avoid Common Azure Loading Elements
    Click Element  //span[text ()="v1"]
    Avoid Common Azure Loading Elements
    Sleep  2s
    Click Element  //span[text ()="2.16.840.1.113883.3.12345"]
    Sleep  2s
    Clear Filter Then Input Text    //input[@placeholder="Search blobs by prefix (case-sensitive)"]    ${filename}
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_not_in_container_${time}.png
    ${status4}  Run Keyword And Return Status   Page Should not Contain Element   //span[text ()="${filename}"]
    Run Keyword If  ${status4}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req PASS : FHIR Bundle json file is not present in the ${container} container of ${VSA} storage account${\n}
    Run Keyword If  not ${status4}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req FAIL : FHIR Bundle json file is present in the ${container} container of ${VSA} storage account${\n}
    Log To The Console  File is not in error container

Valid legacy patient identifier is parsed in api
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Legacy_Patient_ID: ${parameter_list["valid_params"]["legacy_Patient_id"]}${\n}
    ${req_body}=   Set Variable    ${parameter_list["legacy_input_json"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    Log        The Requested Data Is : ${req_body}
    Set Global Variable      ${parameter_list}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["valid_params"]["legacy_Patient_id"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Request Body is {\n} : ${req_body}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["valid_params"]["legacy_Patient_id"]}
    ${response}=    Get On Session   GENERATE_FHIR     /   json=${req_body}
    Status Should Be    OK    ${response}
    Set Global Variable   ${r_response}   ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    ${length}=  Get length         ${data["entry"]}
    Log To Console     ${length}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Details :: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Code is : ${r_response}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${data}${\n}
    ${status}   Run Keyword And Return Status    Should Be Equal    ${data["entry"][-1]["resource"]["id"]}      ${parameter_list["valid_params"]["legacy_Patient_id"]}
    Run Keyword If   ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : DSEP Patient id in the request and response are same - ${parameter_list["valid_params"]["legacy_Patient_id"]}${\n}
    Run Keyword If    not ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : DSEP Patient id in the request and response are not same - ${data["entry"][0]["resource"]["identifier"][1]["value"]}${\n}
    FOR    ${entity}    IN    @{resource_body[0]}
        ${resoruce_type}=   fhir_resource_comaprision   ${data}    ${entity}
        ${status1}  Run Keyword And Return Status      Should Be Equal         ${entity}       ${resoruce_type}
        Run Keyword If   ${status1}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : The Resoruce Type obtained in the response - ${resoruce_type}\n
        Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : The Resoruce Type not obtained in the response - ${resoruce_type}\n
    END


Invalid DSP Patient id is parsed in api
    ${req_body}=   Set Variable    ${parameter_list["allresource_json"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    log to console  ${resource_body}
    Log        The Requested Data Is : ${req_body}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Invalid Patient ID : ${parameter_list["invalid_params"]["invalid_DSEP_Patient_Id"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["invalid_params"]["invalid_DSEP_Patient_Id"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Request Body is {\n} : ${req_body}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["invalid_params"]["invalid_DSEP_Patient_Id"]}
    ${response_invalid}=    Get On Session   GENERATE_FHIR     /   json=${req_body}   expected_status=anything
    set global variable     ${r_response}     ${response_invalid.status_code}
    Status Should Be    Bad Request    ${response_invalid}
    ${response}=    Set Variable   ${response_invalid.json()}
    ${status}   Run Keyword And Return Status    Should Be Equal    Invalid Patient ID     ${response["result"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Details :: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Code is : ${r_response}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${response}${\n}
    Run Keyword If   ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : The error message received is same as message configured - ${response["result"]}\n
    Run Keyword If  not ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : The error message received is not same as message configured - ${response["result"]}\n


Valid DSP Patient id and resource identifier is parsed in API
    ${req_body}=   Set Variable    ${parameter_list["resource_id_json_input"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    log to console        The Requested Data Is : ${resource_body[1]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   DSP_Patient_ID: ${DSEP_PID}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource_identifier: ${resource_body[1]}${\n}
    Set Global Variable      ${parameter_list}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${DSEP_PID}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Request Body is {\n} : ${req_body}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${DSEP_PID}
    ${response}=    Get On Session   GENERATE_FHIR     /   json=${req_body}
    Status Should Be    OK    ${response}
    Set Global Variable   ${r_response}   ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    ${length}=  Get length         ${data["entry"]}
    Log To Console     ${length}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Details :: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Code is : ${r_response}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${data}${\n}
    ${status}   Run Keyword And Return Status    Should Be Equal    ${data["entry"][0]["resource"]["identifier"][1]["value"]}      ${parameter_list["valid_params"]["DSEP_Patient_Id"]}
    Run Keyword If   ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : DSEP Patient id in the request and response are same - ${parameter_list["valid_params"]["DSEP_Patient_Id"]}${\n}
    Run Keyword If    not ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : DSEP Patient id in the request and response are not same - ${data["entry"][0]["resource"]["identifier"][1]["value"]}${\n}
    FOR    ${entity}    IN    @{resource_body[0]}
        ${resoruce_type}=   fhir_resource_comaprision   ${data}    ${entity}
        ${status1}  Run Keyword And Return Status      Should Be Equal         ${entity}       ${resoruce_type}
        Run Keyword If   ${status1}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : The Resoruce Type given in the request and response are same - ${resoruce_type}\n
        Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : The Resoruce Type given in the request and response are not same - ${resoruce_type}\n
    END
    FOR    ${entity}    IN    @{resource_body[1]}
        ${id_type}=  fhir_id_comaprsion   ${data}   ${entity}
        ${status2}  Run Keyword And Return Status      Should Be Equal         ${entity}       ${id_type}
        Run Keyword If   ${status2}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : The resource identifier given in the request and response are same - ${id_type}\n
        Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : The resource identifier not obtained in the response - ${id_type}\n
    END


Invalid Resource type and invalid resource identifier is parsed in api
    ${req_body}=   Set Variable    ${parameter_list["invalid_json_input"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    log to console        The Requested Data Is : ${resource_body[1]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource_identifier: ${resource_body[1]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource_Type: appointmen${\n}
    Log        The Requested Data Is : ${req_body}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["valid_params"]["DSEP_Patient_Id"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Request Body is {\n} : ${req_body}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["valid_params"]["DSEP_Patient_Id"]}
    ${response_invalid}=    Get On Session   GENERATE_FHIR     /   json=${req_body}   expected_status=anything
    set global variable     ${r_response}     ${response_invalid.status_code}
    Status Should Be    Bad Request    ${response_invalid}
    ${response}=    Set Variable   ${response_invalid.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Details :: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Code is : ${r_response}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${response}${\n}
    ${status}   Run Keyword And Return Status    Should Be Equal    Invalid Input JSON     ${response["error"]}
    Run Keyword If   ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : The error message received is same as message configured - ${response["error"]}\n
    Run Keyword If  not ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : The error message received is not same as message configured - ${response["error"]}\n

200 response code is displayed and API provides resources details for the patient from ADLs
    Should be equal as strings    200    ${r_response}

200 response code is displayed and API provides resources details for the patient from Legacy
    Should be equal as strings    200    ${r_response}

200 response code is displayed and API provides resources details for the patient
    Should be equal as strings    200    ${r_response}

200 response code is displayed and API provides resources details for all patients
    Should be equal as strings    200    ${r_response}

400 response code & error message is displayed
    Should be equal as strings    400    ${r_response}


User uploads a file in blob container of Docspera storage account
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Upload a File  ${container_name}  ${DocsperaFile1}.json

User Validate File has been acknowledged in Velys container
    [Arguments]  ${sa_name}  ${container_name}    ${DSA}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    File Should be Present in acknowledgement container  ${container_name}  ${DocsperaFile1}-ACK    ${VSA}
#    Check File Details  ${DocsperaFile1}

Navigate to Docspera Storage account Blob container
    [Arguments]  ${storageAcc}
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  ${AZSearch}  ${storageAcc}
    Click Element  //div[text ()='${storageAcc}']
    Avoid Common Azure Loading Elements
    Sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  StorageAcc-${storageAcc}-Overview_${time}.png
    Wait Until Element Is Visible  //*[text()='Containers']  ${Wait}
    Avoid Common Azure Loading Elements
    Click Element  //*[text()='Containers']
    Avoid Common Azure Loading Elements
    Sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Device_Storage_Account_Blob_Overview_${time}.png
    Log To The Console  Device Storage Account Contains a Blob Service

Click Resource Capture Screenshot
    [Arguments]  ${resourceName}  ${filename}
        Avoid Common Azure Loading Elements
        Click Element  //span[text()="${resourceName}"]
        Avoid Common Azure Loading Elements
        Page Should Contain  ${resourceName}_${ID}.json
        Click Element  //span[text()="${resourceName}_${ID}.json"]
        Avoid Common Azure Loading Elements
        Sleep  4s
        Click Element  (//span[text()='Edit'])[1]
        Avoid Common Azure Loading Elements
        Sleep  1s
        ${resource}  get_captialized  ${resourceName}
        Page Should Contain  ${resource}
        Sleep  5
        ${time}  Get current date
        ${time}  convert date  ${time}  result_format= %H%M%S
        Capture Page Screenshot  Resource_Folder_${resourceName}_${time}.png

Click Patient Resource Capture Screenshot
    [Arguments]  ${resourceName}  ${dsep_id}
        Avoid Common Azure Loading Elements
        Click Element  //span[text()="${resourceName}"]
        Avoid Common Azure Loading Elements
        Page Should Contain  ${resourceName}_${dsep_id}.json
        Click Element  //span[text()="${resourceName}_${dsep_id}.json"]
        Avoid Common Azure Loading Elements
        Sleep  4s
        Click Element  (//span[text()='Edit'])[1]
        Avoid Common Azure Loading Elements
        Sleep  1s
        ${resource}  get_captialized  ${resourceName}
        Page Should Contain  ${resource}
        Sleep  5
        ${time}  Get current date
        ${time}  convert date  ${time}  result_format= %H%M%S
        Capture Page Screenshot  Resource_Folder_${resourceName}_${time}.png

Check File Details
    [Arguments]  ${filename}
    Download JSON File
    Log to console    file details check
    ${json}  Get file  ${DownloadDir}${/}${filename}-ACK.json
    ${fileACK}  Evaluate  json.loads('''${json}''')  json
    Log to console   ${fileACK}
    set Global Variable  ${dsep_id}  ${fileACK["acknowledgement"][0]["DSEP PatientID"]}
    ${status10}  Run Keyword And Return Status   Should Match Regexp  ${fileACK["acknowledgement"][0]["DSEP PatientID"]}  [a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}
    Run Keyword If   ${status10}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : DSEP Patient id is generated as ${fileACK["acknowledgement"][0]["DSEP PatientID"]}${\n}
    Run Keyword If  not ${status10}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : DSEP Patient id is not generated as ${fileACK["acknowledgement"][0]["DSEP PatientID"]}${\n}

File Should be Present in acknowledgement container
    [Arguments]  ${container}  ${filename}    ${StorageAcc}
    Sleep  10
    Click Element  //div[text ()='${container}']
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  //input[@placeholder='Search blobs by prefix (case-sensitive)']    ${filename}.json
    Sleep  2 s
    ${status2}  Run Keyword And Return Status   Page Should Contain  ${filename}.json
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req PASS : FHIR Bundle json file is present in the ${container} container of ${StorageAcc} storage account${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req FAIL : FHIR Bundle json file is not present in the ${container} container of ${StorageAcc} storage account${\n}
    Click Element  //span[text()='${filename}.json']
    Avoid Common Azure Loading Elements
    Sleep  5 s
    Click Element  (//span[text()='Edit'])[1]
    Avoid Common Azure Loading Elements
    Sleep  10 s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Details_Uploaded_to_Blob_${time}.png
    ${data} =     json_import.json Download      ${parameter_list["connection_params"]["STORAGEACCOUNTURL"]}    ${parameter_list["connection_params"]["STORAGEACCOUNTKEY"]}     ${parameter_list["connection_params"]["CONTAINERNAME"]}     ${parameter_list["connection_params"]["BLOBNAME"]}
    ${data1}  Evaluate  json.loads('''${data}''')  json
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Acknowledgment JSON : ${data1}${\n}
    set Global Variable  ${DSEP_PID}    ${data1["acknowledgement"]["DSEP PatientID"]}
    Log To The Console  ........................../${DSEP_PID}
    Log To The Console  File Details Uploaded To Blob

Upload a File
    [Arguments]  ${container}  ${filename}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Sleep  8
    Click Element  //div[text ()='Upload']
    Avoid Common Azure Loading Elements
    Sleep  4s
    Wait Until Element Is Visible  //h2[text()='Upload blob']  ${Wait}
    Sleep  4s
    Log To Console    ${workDir}
    Choose File     ${File_upload_Field}     ${workDir}/dsp_daa_fhir_layering/configurationfiles/${env}/testdata/${filename}
    Sleep  4s
    Click Element  ${Upload_Button}
    Avoid Common Azure Loading Elements
    Log To Console    ${CURDIR}${/}
    Sleep  4s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Upload_Completed_${time}.png
    Click Element  //h2[text()='Upload blob']/following-sibling::div/button[@title='Close']
    Avoid Common Azure Loading Elements
    Page Should Contain  ${filename}
    Sleep  30s
    Click Element  (//div[text ()='Refresh'])[2]
    Avoid Common Azure Loading Elements
    ${status}  Run Keyword And Return Status   Page Should Not Contain  ${filename}
    Log to console    ${status}
    Run Keyword If   ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req PASS : FHIR Bundle json file is processed from docspera-adls container of ${DSA} storage account${\n}
    Run Keyword If  not ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req FAIL : FHIR Bundle json file is not processed from docspera-adls container of ${DSA} storage account${\n}
    Avoid Common Azure Loading Elements

Navigate to practitioner Directory
    [Arguments]  ${container}
    Sleep  10
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Sleep   10
    Avoid Common Azure Loading Elements
    Click Element  //span[text ()="v1"]
    Avoid Common Azure Loading Elements
    Sleep  5
    Click Element  //span[text ()="2.16.840.1.113883.3.12345"]


Navigate to file resource Directory
    [Arguments]  ${container}  ${dsep_id}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Avoid Common Azure Loading Elements
    Sleep  3s
    Click Element  //span[text ()="v1"]
    Avoid Common Azure Loading Elements
    Sleep  1s
    Click Element  //span[text ()="2.16.840.1.113883.3.12345"]
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  //input[@placeholder='Search blobs by prefix (case-sensitive)']    ${dsep_id}
    Sleep  2s
    Log to console    ${dsep_id}
    Input Text  //input[@aria-label="Search blobs by prefix (case-sensitive)"]  ${dsep_id}
    Sleep  5
    Click Element  //span[text ()='${dsep_id}']
    Sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${dsep_id}_Patient_Details_${time}.png
    Sleep  5
    Click Element  //span[text ()='appointment']
    Sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${dsep_id}_Resource_Details_${time}.png

Navigate to Patient Directory
    [Arguments]  ${container}  ${dsep_id}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Avoid Common Azure Loading Elements
    Sleep  3s
    Click Element  //span[text ()="v1"]
    Avoid Common Azure Loading Elements
    Sleep  1s
    Click Element  //span[text ()="2.16.840.1.113883.3.12345"]
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  //input[@placeholder='Search blobs by prefix (case-sensitive)']    ${dsep_id}
    Sleep  2s
    Log to console    ${dsep_id}
    Input Text  //input[@aria-label="Search blobs by prefix (case-sensitive)"]  ${dsep_id}
    Sleep  5
    Click Element  //span[text ()='${dsep_id}']
    Sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${dsep_id}_Patient_Details_${time}.png
    Click Element  //span[text ()='appointment']
    Sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${dsep_id}_Appointment_Details_${time}.png


Blank DSEP Patient id is parsed in api
    ${req_body}=   Set Variable    ${parameter_list["allresource_json"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    log to console  ${resource_body}
    Log        The Requested Data Is : ${req_body}
    Append to File  ${API_Output_filePath}${TC_ID}.txt    Patient ID: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Request Body is {\n} : ${req_body}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}
    ${response}=    Get On Session   GENERATE_FHIR     /   json=${req_body}   expected_status=anything
    set global variable     ${r_response}     ${response.status_code}
    Status Should Be    OK   ${response}
    Set Global Variable   ${r_response}   ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Details :: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Code is : ${r_response}${\n}
    ${status1}  Run Keyword And Return Status      Should Not Be Empty         ${data}
    Run Keyword If   ${status1}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Response is received for all patient resource type ${\n}
    Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Response is not received ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${data}${\n}



Download JSON File
    Avoid Common Azure Loading Elements
    Click element  //div[contains(text(), "Download")]
    Sleep  2s