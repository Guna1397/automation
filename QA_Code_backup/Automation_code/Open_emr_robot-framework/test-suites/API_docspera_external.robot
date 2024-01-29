*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-216

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

Suite Setup  Run Keywords  Initialize DocSpera Storage Account Variables  Initialize DocSpera Key Vault Secret Variables    Initialize Docspera Storage Account Groups Variables    Remove Output files
Test Setup          Create API Output Tag List
Test Teardown       Run Keywords  User has a Valid API Response  Logout Azure Portal and close Browser

*** Variables ***
${DocsperaFile1}=    9f801853-50ee-4195-9396-a39b6cc31956
${DownloadDir}=  ${CURDIR}/downloads_robot/

${dsep_id}
${ID}
${workDir}     C:\Users\vipant\Desktop\Deloitte\JNJProjects\DS\PI9\DocSpera\Code\dsp_daa_fhir_layering

${Legacy_ID}
${DSEP_PID}
*** Test Cases ***
#TC01
Validate success response are fetched when SAS token is parsed in docspera external API
    [Tags]      JAYU-432
    Given SAS token is configure for docspera-adls container
    And Docspera External API is available
    When Valid SAS token is parsed in api
    Then 200 response code is displayed and API provides resources details for the patient

Validate error message when invalid SAS token is parsed in docspera external API
    [Tags]      JAYU-433
    Given SAS token is configure for docspera-adls container
    And Docspera External API is available
    When Invalid SAS token is parsed in api
    Then 403 response code is displayed

#Validate error message when expired SAS token is parsed in docspera external API
#    [Tags]      JAYU-434
#    Given Expired SAS token is configure for docspera-adls container
#    And Docspera External API is available
#    When Expired SAS token is parsed in api
#    Then 403 response code is displayed

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

#User is logged into Azure & user has required Subscription
SAS token is configure for docspera-adls container
    Log To The Console  env: ${env}
    Initialize Subscription Variable
    User Launches Azure Portal
    User Enters Valid Azure Credentials  Uname=${AZUserContributor}  Pass=${AZPassword}
    Check For Custom Subscription Then Set Subscription  ${AZUserContributor}
    User Validates DocSpera Key Vault Secret Configuration
    User has Valid SAS Token for DocSpera SA containers

User Validates DocSpera Key Vault Secret Configuration
    Log To The Console  Validating DocSpera Key Vault Secret Configuration

User has Valid SAS Token for DocSpera SA containers
    ${DOCSPERAKVSECRETSCntTotal}=  Get Length  ${DOCSPERAKVSECRETS2}
    FOR  ${DOCSPERAKVSECRETCnt}  IN RANGE  ${DOCSPERAKVSECRETSCntTotal}
        Log To The Console  ${DOCSPERAKVSECRETS2[${DOCSPERAKVSECRETCnt}]}
        Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
        Click Element  ${AZSearchBox}
        Sleep  2s
        Input Text  ${AZSearchBox}  ${DOCSPERAKVNAME2}
        Wait Until Element Is Visible  //*[text ()='${DOCSPERAKVNAME2}']  ${Wait}
        Sleep  5s
        Click Element  //*[text ()='${DOCSPERAKVNAME2}']
        Wait Until Element Is Visible  link:Secrets
        Click Element  link:Secrets
        Set Window Size  2440  1200
        Sleep  10s
        Capture Page Screenshot  ${DOCSPERAKVSECRETS2[${DOCSPERAKVSECRETCnt}]}_kv_secret_access.png
        Click Element  link:Load more
        Wait Until Element Is Visible  //*[text()='${DOCSPERAKVSECRETS2[${DOCSPERAKVSECRETCnt}]}']  ${Wait}
        Click Element  //*[text()='${DOCSPERAKVSECRETS2[${DOCSPERAKVSECRETCnt}]}']
        Sleep  5s
#        Log To The Console    ---
        ${version_elements} =   Get WebElements      xpath://td[@aria-readonly="true"]
        ${verlen}=  Get Length  ${version_elements}
        ${count}=   Evaluate   ${verlen} - 3
        Press Keys  (//td[@aria-readonly="true"])[${count}]  ENTER
#        ${secret1}=    Get Text    (*//div[text()='CURRENT VERSION']//following::div)[1]
#        Log To The Console    ---${secret1}
#        Click Element  //td[@data-activatable="true"]/div[text()="${secret1}"]
#        Press Keys    (*//div[text()='CURRENT VERSION']//following::div)[1]    ENTER
#        Press Keys    //body[@class='fxs-theme-azure fxs-mode-light ext-mode-light fxs-mode-standardcontrast ext-mode-standardcontrast fxs-hidefocusoutline']    ENTER
        Wait Until Element Is Visible  //*[@title='Show Secret Value']  ${Wait}
        Sleep  1s
        Click Element  //*[@title='Show Secret Value']
        Sleep  5s
        Capture Page Screenshot  ${DOCSPERAKVSECRETS2[${DOCSPERAKVSECRETCnt}]}_sas_token_duration.png
        Page Should Contain Element   //*[starts-with(@title, '${DOCSPERAKVSECRETEXP2}')]
        Sleep  2s
    END

Expired SAS token is configure for docspera-adls container
    Log To The Console  env: ${env}
    Initialize Subscription Variable
    User Launches Azure Portal
    User Enters Valid Azure Credentials  Uname=${AZUserContributor}  Pass=${AZPassword}
    Check For Custom Subscription Then Set Subscription  ${AZUserContributor}
    User Validates DocSpera Key Vault Secret Configuration expired
    User has expired SAS Token for DocSpera SA containers

User Validates DocSpera Key Vault Secret Configuration expired
    Log To The Console  Validating DocSpera Key Vault Secret Configuration

User has expired SAS Token for DocSpera SA containers
    ${DOCSPERAKVSECRETSCntTotal}=  Get Length  ${DOCSPERAKVSECRETS3}
    FOR  ${DOCSPERAKVSECRETCnt}  IN RANGE  ${DOCSPERAKVSECRETSCntTotal}
        Log To The Console  ${DOCSPERAKVSECRETS3[${DOCSPERAKVSECRETCnt}]}
        Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
        Click Element  ${AZSearchBox}
        Sleep  2s
        Input Text  ${AZSearchBox}  ${DOCSPERAKVNAME3}
        Wait Until Element Is Visible  //*[text ()='${DOCSPERAKVNAME3}']  ${Wait}
        Click Element  //*[text ()='${DOCSPERAKVNAME3}']
        Wait Until Element Is Visible  link:Secrets
        Click Element  link:Secrets
        Set Window Size  2440  1200
        Sleep  10s
        Capture Page Screenshot  ${DOCSPERAKVSECRETS3[${DOCSPERAKVSECRETCnt}]}_kv_secret_access.png
        Click Element  link:Load more
        Wait Until Element Is Visible  //*[text()='${DOCSPERAKVSECRETS3[${DOCSPERAKVSECRETCnt}]}']  ${Wait}
        Click Element  //*[text()='${DOCSPERAKVSECRETS3[${DOCSPERAKVSECRETCnt}]}']
        Sleep  5s
        ${version_elements} =   Get WebElements      xpath://td[@aria-readonly="true"]
        ${verlen}=  Get Length  ${version_elements}
        ${count}=   Evaluate   ${verlen} - 3
        Press Keys  (//td[@aria-readonly="true"])[${count}]  ENTER
        Wait Until Element Is Visible  //*[@title='Show Secret Value']  ${Wait}
        Sleep  1s
        Click Element  //*[@title='Show Secret Value']
        Sleep  5s
        Capture Page Screenshot  ${DOCSPERAKVSECRETS3[${DOCSPERAKVSECRETCnt}]}_sas_token_duration.png
        Page Should Contain Element   //*[starts-with(@title, '${DOCSPERAKVSECRETEXP3}')]
        Sleep  2s
    END

Valid SAS token is parsed in api
    ${parameter_list}=      param_docspera_ext    ${env}
    Set Global Variable      ${parameter_list}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   SAS Token : ${parameter_list["SAS_token"]}${\n}
    ${token_param}=         sas_splitter    ${env}  ${parameter_list["SAS_token"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Valid Till : ${token_param["se"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   SAS signature : ${token_param["sig"]}${\n}
    Create session   DOCSPERAEXTERNAL    ${parameter_list["base_url"]}
    #${response}=    Get request   DOCSPERAEXTERNAL    /${parameter_list["access_storage"]}/${parameter_list["file_name"]}  params=${parameter_list["SAS_token"]}
    ${response}=     Get  ${parameter_list["base_url"]}&${parameter_list["SAS_token"]}
    Set Global Variable   ${r_response}   ${response.status_code}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Details:: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Body::${response.json}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Code::${response}${\n}
    ${status_availability}  Run Keyword And Return Status    Should be equal as strings    ${response.status_code}    200
    Run Keyword If   ${status_availability}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Docspera External API provides with valid response${\n}
    Run Keyword If  not ${status_availability}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Docspera External API provides invalid response${\n}


Invalid SAS token is parsed in api
    ${parameter_list}=      param_docspera_ext    ${env}
    Set Global Variable      ${parameter_list}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Invalid SAS Token : ${parameter_list["invalid_SAS_token"]}${\n}
    ${token_param}=         sas_splitter    ${env}  ${parameter_list["invalid_SAS_token"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Valid Till : ${token_param["se"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Invalid SAS signature : ${token_param["sig"]}${\n}
    Create session   DOCSPERAEXTERNAL    ${parameter_list["base_url"]}
    #${response}=    Get request   DOCSPERAEXTERNAL    /${parameter_list["access_storage"]}/${parameter_list["file_name"]}   params=${parameter_list["invalid_SAS_token"]}
    ${response}=     Get    ${parameter_list["base_url"]}&${parameter_list["invalid_SAS_token"]}    expected_status=anything
    Set Global Variable   ${r_response}   ${response.status_code}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Details:: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Body::${response.json}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Code::${response}${\n}
    ${status_availability}  Run Keyword And Return Status    Should be equal as strings    ${response.status_code}    403
    Run Keyword If   ${status_availability}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Docspera External API provides error response due to invalid SAS token${\n}
    Run Keyword If  not ${status_availability}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Docspera External API provides error response due to invalid SAS token${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Error Message Displayed is : ${response.reason}${\n}

Expired SAS token is parsed in api
    ${parameter_list}=      param_docspera_ext    ${env}
    Set Global Variable      ${parameter_list}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Invalid SAS Token : ${parameter_list["invalid_expiry_SAS_token"]}${\n}
    ${token_param}=         sas_splitter    ${env}  ${parameter_list["invalid_expiry_SAS_token"]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   InValid Date : ${token_param["se"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   SAS signature : ${token_param["sig"]}${\n}
    Create session   DOCSPERAEXTERNAL    ${parameter_list["base_url"]}
    #${response}=    Get request   DOCSPERAEXTERNAL    /${parameter_list["access_storage"]}/${parameter_list["file_name"]}   params=${parameter_list["invalid_expiry_SAS_token"]}
    ${response}=     Get    ${parameter_list["base_url"]}&${parameter_list["invalid_expiry_SAS_token"]}    expected_status=anything
    Set Global Variable   ${r_response}   ${response.status_code}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Details:: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Body::${response.json}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Response Code::${response}${\n}
    ${status_availability}  Run Keyword And Return Status    Should be equal as strings    ${response.status_code}    403
    Run Keyword If   ${status_availability}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Docspera External API provides error response due to expired date in SAS token${\n}
    Run Keyword If  not ${status_availability}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Docspera External API provides error response due to expired date in SAS token${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Error Message Displayed is : ${response.reason}${\n}



Patient details from DocSpera are added in Velys container
    Initialize Docspera Variables
    User is logged into Azure & user has required Subscription
    User uploads a file in blob container of Docspera storage account  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}
    User Validate File has been acknowledged in Velys container  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][3]}    ${VSA}
    User Validate File has been acknowledged in Docspera storage account    ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][3]}      ${DSA}


User Validate File has been acknowledged in Docspera storage account
    [Arguments]  ${sa_name}  ${container_name}    ${DSA}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    File Should be Present in acknowledgement container  ${container_name}  ${DocsperaFile1}-ACK   ${DSA}

Navigate to Docspera Storage account Blob container
    [Arguments]  ${storageAcc}
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  ${AZSearch}  ${storageAcc}
    Click Element  //div[text ()='${storageAcc}']
    Avoid Common Azure Loading Elements
    Capture Page Screenshot  StorageAcc-${storageAcc}-Overview.png
    Wait Until Element Is Visible  //*[text()='Containers']  ${Wait}
    Avoid Common Azure Loading Elements
    Click Element  //*[text()='Containers']
    Avoid Common Azure Loading Elements
    Capture Page Screenshot  Device_Storage_Account_Blob.png
    Log To The Console  Device Storage Account Contains a Blob Service

File Should be Present in acknowledgement container
    [Arguments]  ${container}  ${filename}    ${StorageAcc}
    Click Element  //div[text ()='${container}']
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  //input[@placeholder='Search blobs by prefix (case-sensitive)']    ${filename}.json
    Sleep  2 s
    ${status2}  Run Keyword And Return Status   Page Should Contain  ${filename}.json
    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : FHIR Bundle json file is present in the ${container} container of ${StorageAcc} storage account${\n}
    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : FHIR Bundle json file is not present in the ${container} container of ${StorageAcc} storage account${\n}
    Click Element  //span[text()='${filename}.json']
    Avoid Common Azure Loading Elements
    Sleep  2 s
    Click Element  (//span[text()='Edit'])[1]
    Avoid Common Azure Loading Elements
    Sleep  1 s
    Capture Page Screenshot  ${filename}_File_Details_Uploaded_to_Blob.png
    Log To The Console  File Details Uploaded To Blob

Velys Patient FHIR API is available
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** FHIR Patient API Results *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   FHIR Patient API Base URL: ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${\n}
    Create session    PATIENTFHIRAPI      ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}

Docspera External API is available
    ${parameter_list}=      param_docspera_ext    ${env}
    Append To File  ${API_Output_filePath}${TC_ID}.txt  ********** Docspera External API Results *********${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   DOCSPERA External API Base URL: ${parameter_list["base_url"]}${\n}
    Create session    DOCSPERAEXTERNAL    ${parameter_list["base_url"]}

Valid DSP Patient ID is parsed in API
    ${parameter_list}=    fhir param jsoner     ${env}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   DSEP_Patient_ID: ${DSEP_PID}${\n}
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
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${data}${\n}
    Run Keyword If   ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : DSEP Patient id in the request and response are same - ${data["entry"][0]["resource"]["identifier"][1]["value"]}${\n}
    Run Keyword If    not ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : DSEP Patient id in the request and response are not same - ${data["entry"][0]["resource"]["identifier"][1]["value"]}${\n}
    FOR    ${entity}    IN    @{resource_body[0]}
        ${resoruce_type}=   fhir_resource_comaprision   ${data}    ${entity}
        ${status1}  Run Keyword And Return Status      Should Be Equal         ${entity}       ${resoruce_type}
        Run Keyword If   ${status1}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : The Resoruce Type obtained in the response - ${resoruce_type}${\n}
        Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : The Resoruce Type not obtained in the response - ${resoruce_type}${\n}
    END

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


Invalid DSEP Patient id is parsed in api
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["invalid_params"]["invalid_DSEP_Patient_Id"]}${\n}
    ${req_body}=   Set Variable    ${parameter_list["allresource_json"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    log to console  ${resource_body}
    Log        The Requested Data Is : ${req_body}
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


Valid DSEP Patient id and resource identifier is parsed in api
    Append To File  ${API_Output_filePath}${TC_ID}.txt   DSEP_Patient_ID: ${parameter_list["valid_params"]["DSEP_Patient_Id"]}${\n}
    ${req_body}=   Set Variable    ${parameter_list["resource_id_json_input"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    log to console        The Requested Data Is : ${resource_body[1]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource_identifier: ${resource_body[1]}${\n}
    Log        The Requested Data Is : ${req_body}
    Set Global Variable      ${parameter_list}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["valid_params"]["DSEP_Patient_Id"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Request Body is {\n} : ${req_body}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["valid_params"]["DSEP_Patient_Id"]}
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


Invalid DSEP Patient id and invalid resource identifier is parsed in api
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["invalid_params"]["invalid_DSEP_Patient_Id"]}${\n}
    ${req_body}=   Set Variable    ${parameter_list["invalid_json_input"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    log to console        The Requested Data Is : ${resource_body[1]}
    Append To File  ${API_Output_filePath}${TC_ID}.txt   Resource_identifier: ${resource_body[1]}${\n}
    Log        The Requested Data Is : ${req_body}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["invalid_params"]["invalid_DSEP_Patient_Id"]}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Request Body is {\n} : ${req_body}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["invalid_params"]["invalid_DSEP_Patient_Id"]}
    ${response_invalid}=    Get On Session   GENERATE_FHIR     /   json=${req_body}   expected_status=anything
    set global variable     ${r_response}     ${response_invalid.status_code}
    Status Should Be    Bad Request    ${response_invalid}
    ${response}=    Set Variable   ${response_invalid.json()}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Details :: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Code is : ${r_response}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${response}${\n}
    ${status}   Run Keyword And Return Status    Should Be Equal    Invalid Patient ID     ${response["result"]}
    Run Keyword If   ${status}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : The error message received is same as message configured - ${response["result"]}\n
    Run Keyword If  not ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : The error message received is not same as message configured - ${response["result"]}\n

200 response code is displayed and API provides resources details for the patient
    Should be equal as strings    200    ${r_response}

400 response code & error message is displayed
    Should be equal as strings    400    ${r_response}

403 response code is displayed
    Should be equal as strings    403    ${r_response}

User uploads a file in blob container of Docspera storage account
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Upload a File  ${container_name}  ${DocsperaFile1}.json

User Validate File has been acknowledged in Velys container
    [Arguments]  ${sa_name}  ${container_name}    ${DSA}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    File Should be Present in acknowledgement container  ${container_name}  ${DocsperaFile1}-ACK    ${VSA}
#    Check File Details  ${DocsperaFile1}

#Navigate to Docspera Storage account Blob container
#    [Arguments]  ${storageAcc}
#    Avoid Common Azure Loading Elements
#    Clear Filter Then Input Text  ${AZSearch}  ${storageAcc}
#    Click Element  //div[text ()='${storageAcc}']
#    Avoid Common Azure Loading Elements
#    ${time}  Get current date
#    ${time}  convert date  ${time}  result_format= %H%M%S
#    Capture Page Screenshot  StorageAcc-${storageAcc}-Overview_${time}.png
#    Wait Until Element Is Visible  //*[text()='Containers']  ${Wait}
#    Avoid Common Azure Loading Elements
#    Click Element  //*[text()='Containers']
#    Avoid Common Azure Loading Elements
#    ${time}  Get current date
#    ${time}  convert date  ${time}  result_format= %H%M%S
#    Capture Page Screenshot  Device_Storage_Account_Blob_Overview_${time}.png
#    Log To The Console  Device Storage Account Contains a Blob Service

Click Resource Capture Screenshot
    [Arguments]  ${resourceName}  ${filename}
        Avoid Common Azure Loading Elements
        Click Element  //span[text()="${resourceName}"]
        Avoid Common Azure Loading Elements
        Page Should Contain  ${resourceName}_${ID}.json
        Click Element  //span[text()="${resourceName}_${ID}.json"]
        Avoid Common Azure Loading Elements
        Sleep  1s
        Click Element  (//span[text()='Edit'])[1]
        Avoid Common Azure Loading Elements
        Sleep  1s
        ${resource}  get_captialized  ${resourceName}
        Page Should Contain  ${resource}
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
        Sleep  1s
        Click Element  (//span[text()='Edit'])[1]
        Avoid Common Azure Loading Elements
        Sleep  1s
        ${resource}  get_captialized  ${resourceName}
        Page Should Contain  ${resource}
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

#File Should be Present in acknowledgement container
#    [Arguments]  ${container}  ${filename}    ${StorageAcc}
#    Sleep  10
#    Click Element  //div[text ()='${container}']
#    Avoid Common Azure Loading Elements
#    Clear Filter Then Input Text  //input[@placeholder='Search blobs by prefix (case-sensitive)']    ${filename}.json
#    Sleep  2 s
#    ${status2}  Run Keyword And Return Status   Page Should Contain  ${filename}.json
#    Run Keyword If   ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req PASS : FHIR Bundle json file is present in the ${container} container of ${StorageAcc} storage account${\n}
#    Run Keyword If  not ${status2}    Append To File  ${API_Output_filePath}${TC_ID}.txt  Pre-Req FAIL : FHIR Bundle json file is not present in the ${container} container of ${StorageAcc} storage account${\n}
#    Click Element  //span[text()='${filename}.json']
#    Avoid Common Azure Loading Elements
#    Sleep  2 s
#    Click Element  (//span[text()='Edit'])[1]
#    Avoid Common Azure Loading Elements
#    Sleep  10 s
#    ${time}  Get current date
#    ${time}  convert date  ${time}  result_format= %H%M%S
#    Capture Page Screenshot  ${filename}_File_Details_Uploaded_to_Blob_${time}.png
#    ${data} =     json_import.json Download
#    ${data1}  Evaluate  json.loads('''${data}''')  json
#    set Global Variable  ${DSEP_PID}    ${data1["acknowledgement"][0]["DSEP PatientID"]}
#    Log To The Console  ........................../${DSEP_PID}
#    Log To The Console  File Details Uploaded To Blob

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
    Click Element  //span[text ()='${dsep_id}']

Blank DSEP Patient id is parsed in api
#    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${parameter_list["invalid_params"]["invalid_DSEP_Patient_Id"]}${\n}
    ${req_body}=   Set Variable    ${parameter_list["blank_resource_json"]}
    ${resource_body}=  fhir_resource_jsoner    ${env}    ${req_body}
    log to console  ${resource_body}
    Log        The Requested Data Is : ${req_body}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    The request is been through the API : ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}${\n}
    Create session  GENERATE_FHIR  ${parameter_list["fhir_api_url_params"]["fhir_patient_base_url"]}
    ${response}=    Get On Session   GENERATE_FHIR     /   json=${req_body}   expected_status=anything
    set global variable     ${r_response}     ${response.status_code}
    Status Should Be    OK   ${response}
    Set Global Variable   ${r_response}   ${response.status_code}
    ${data}=     Set Variable    ${response.json()}
    ${length}=  Get length         ${data["entry"]}
    Log To Console     ${data}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Details :: ${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Code is : ${r_response}${\n}
    Append To File  ${API_Output_filePath}${TC_ID}.txt    Response Body is : ${data}${\n}
    ${status1}  Run Keyword And Return Status      Should Not Be Empty         ${data}
    Run Keyword If   ${status1}   Append To File  ${API_Output_filePath}${TC_ID}.txt   PASS : Response is received for all patient resource type
    Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt   FAIL : Response is not received


Download JSON File
    Avoid Common Azure Loading Elements
    Click element  //div[contains(text(), "Download")]
    Sleep  2s