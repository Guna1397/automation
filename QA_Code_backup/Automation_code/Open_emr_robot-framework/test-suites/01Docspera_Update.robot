*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-218


###Author: Dayanidhi Kasi ###
Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections
Library  RequestsLibrary
Library  ../scripts/validation.py
Library  ../scripts/api_output_generation.py

Resource  Variables.robot
Resource  Locators.robot
Resource  CommonKeywords.robot
Resource  Support_API.robot

Suite Setup         Initialize Docspera Variables
Test Setup          Create API Output Tag List
Test Teardown       User has a Valid API Response
Suite Teardown      Close All Browsers

*** Variables ***
${HSDI_M_SACnt}
${env}
${DocsperaFile1}=    9f801853-50ee-4195-9396-a39b6cc31956
${DownloadDir}=  ${CURDIR}/downloads_robot/
${BaseURL}=  https://filescanner-api.api-apd-afl.thesurgicalnet.com
${dsep_id}
${ID}
${workDir}
@{List}

*** Test Cases ***
## TC02
Update Patient details from DOCSPERA to DSP
    [Tags]      JAYU-295
    Given User is logged into Azure & user has required Subscription
    When User uploads a file in docspera-adls container of Docspera storage account for patient update  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}
    Then User validates that file is moved from docspera-adls container of Docspera storage account  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}  ${DocsperaFile1}.json
    And User validates that file is archived in docpsera-archive container of Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][2]}
    And User validates that file is not present in dlq container of Velys storage account   ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][4]}
    And User validate that acknowledgement is saved in docspera-ack container of Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][3]}    ${VSA}
    And User validates patient details are organied in resource folders in dsep container of Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][0]}
    And User validate that acknowledgment is archived in docspera-ack-archive container of Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][8]}    ${VSA}
    And User validate that acknowledgement is sent to docspera-ack container of DocSpera storage account    ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][3]}      ${DSA}

*** Keywords ***
Initialize Docspera Variables
     ${json}  Get file  ${basejsonfilepath}docspera-storage-accounts_RobotTest.json
    ${DS}  Evaluate  json.loads('''${json}''')  json
    set Global Variable  ${DocsperaSA}  ${DS}
    set Global Variable   ${DSA}    ${DocsperaSA[2]["name"]}
    set Global Variable   ${VSA}    ${DocsperaSA[1]["name"]}
    ${Bundlejson}  Get file  ../dsp_daa_fhir_layering/configurationfiles/${env}/testdata/9f801853-50ee-4195-9396-a39b6cc31956.json
    ${Bundle}  Evaluate  json.loads('''${Bundlejson}''')  json
    set Global Variable  ${ID}  ${Bundle["entry"][0]["resource"]["id"]}
    ${totalLen}=  get length  ${Bundle["entry"]}
    FOR    ${i}    IN RANGE   ${totalLen}
        Run Keyword If   "${Bundle["entry"][${i}]["resource"]["resourceType"]}" == "Patient"    Get PatientID   ${Bundle}  ${i}
    END

Get PatientID
    [Arguments]  ${resource}  ${index}
    Run Keyword If   "${resource["entry"][${index}]["resource"]["identifier"][1]["system"]}" == "DSP Patient ID"   set Global Variable  ${dsep_id}  ${resource["entry"][${index}]["resource"]["identifier"][1]["value"]}

User validate that acknowledgment is archived in docspera-ack-archive container of Velys storage account
    [Arguments]  ${sa_name}  ${container_name}    ${DSA}
    Navigate to Storage account Blob container  ${sa_name}
    File Should be Present in acknowledgement container  ${container_name}  ${DocsperaFile1}-ACK    ${DSA}

User uploads a file in docspera-adls container of Docspera storage account for patient update
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Storage account Blob container  ${sa_name}
    Upload a File  ${container_name}  ${DocsperaFile1}.json

User validates that file is moved from docspera-adls container of Docspera storage account
    [Arguments]  ${sa_name}  ${container_name}  ${filename}
    Sleep    20s
    Click Element  (//div[text ()='Refresh'])[2]
	Sleep    5s
    Avoid Common Azure Loading Elements
    ${status}  Run Keyword And Return Status   Page Should Not Contain  ${filename}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  StorageAcc-${sa_name}-File_Not_Present_${time}.png
    Log to console    ${status}
    Run Keyword If   ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : FHIR Bundle json file is processed from docspera-adls container of ${DSA} storage account${\n}
    Run Keyword If  not ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : FHIR Bundle json file is not processed from docspera-adls container of ${DSA} storage account${\n}
    Avoid Common Azure Loading Elements

User validate that acknowledgement is saved in docspera-ack container of Velys storage account
    [Arguments]  ${sa_name}  ${container_name}    ${DSA}
    Navigate to Storage account Blob container  ${sa_name}
    File Should be Present in acknowledgement container  ${container_name}  ${DocsperaFile1}-ACK    ${DSA}
    Check File Details  ${DocsperaFile1}

User validates patient details are organied in resource folders in dsep container of Velys storage account
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Storage account Blob container  ${sa_name}
    Navigate to practitioner Directory  ${container_name}
    Validate Practitioner Folder contains File  ${container_name}  ${dsep_id}
    Navigate to file resource Directory  ${container_name}  ${dsep_id}
    Validate Each Resource Folder Contains file  ${dsep_id}

User validate that acknowledgement is sent to docspera-ack container of DocSpera storage account
    [Arguments]  ${sa_name}  ${container_name}    ${DSA}
    Navigate to Storage account Blob container  ${sa_name}
    File Should be Present in acknowledgement container  ${container_name}  ${DocsperaFile1}-ACK   ${DSA}

User validates that file is archived in docpsera-archive container of Velys storage account
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Storage account Blob container  ${sa_name}
    File Should Be Present In Archieve Container  ${container_name}  ${DocsperaFile1}

User validates that file is not present in dlq container of Velys storage account
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Storage account Blob container  ${sa_name}
    File Should Not be Present in dlq container  ${container_name}  ${DocsperaFile1}

User Validate Resource Folders in dsep container of Velys storage account
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Storage account Blob container  ${sa_name}
    Navigate to practitioner Directory  ${container_name}
    Validate Practitioner Folder contains File  ${container_name}  ${dsep_id}
    Navigate to file resource Directory  ${container_name}  ${dsep_id}
    Validate Each Resource Folder Contains file  ${dsep_id}


Navigate to Storage account Blob container
    [Arguments]  ${storageAcc}
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  ${AZSearch}  ${storageAcc}
    Click Element  //div[text ()='${storageAcc}']
    Avoid Common Azure Loading Elements
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  StorageAcc-${storageAcc}-Overview_${time}.png
    Wait Until Element Is Visible  //*[text()='Containers']  ${Wait}
    Avoid Common Azure Loading Elements
    Click Element  //*[text()='Containers']
    Avoid Common Azure Loading Elements
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Device_Storage_Account_Blob_${time}.png
    Log To The Console  Device Storage Account Contains a Blob Service

Navigate to practitioner Directory
    [Arguments]  ${container}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Sleep    2s
    Avoid Common Azure Loading Elements
    Click Element  //span[text ()="v1"]
    Avoid Common Azure Loading Elements
    Sleep  2s
    Click Element  //span[text ()="2.16.840.1.113883.3.12345"]


Navigate to file resource Directory
    [Arguments]  ${container}  ${dsep_id}
    Avoid Common Azure Loading Elements
    Sleep  3s
#    Click Element  //span[text ()="v1"]
#    Avoid Common Azure Loading Elements
#    Sleep  1s
#    Click Element  //span[text ()="2.16.840.1.113883.3.12345"]
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  //input[@placeholder='Search blobs by prefix (case-sensitive)']    ${dsep_id}
    Sleep  2s
    Log to console    ${dsep_id}
    Click Element  //span[text ()='${dsep_id}']



Validate Practitioner Folder contains File
    [Arguments]  ${container_name}  ${filename}
    Avoid Common Azure Loading Elements
    Sleep  2s
    Clear Filter Then Input Text  //input[@placeholder='Search blobs by prefix (case-sensitive)']    practitioner
    Sleep  2s
    Click Element   //span[text()="practitioner"]
    Sleep  5s
    Avoid Common Azure Loading Elements
    ${status5}  Run Keyword And Return Status   Page Should Contain  practitioner_${ID}.json
    Run Keyword If   ${status5}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Practitioner resource type file is present in the practitioner folder(DSEP Containter) of ${VSA} storage account${\n}
    Run Keyword If  not ${status5}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Practitioner resource type file is not present in the practitioner folder(DSEP Containter) of ${VSA} storage account${\n}
    Sleep  1s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Practitioner_File_${ID}_${time}.png
    Sleep  5s
    Click Element  //span[text()='practitioner_${ID}.json']
    Sleep  3s
    Click Element  //span[text()='practitioner_${ID}.json']
    Sleep  3s
    Click Element  (//span[text()='Edit'])[1]
    Avoid Common Azure Loading Elements
    Sleep  1s
    Capture Page Screenshot  Practitioner_data_${ID}_${time}.png
    Click Element    //span[@class='fx-grid-formatters-svgtext' and text()='[..]']
    Sleep  5s
    Click Element  link:${container_name}
#    Capture Page Screenshot  Practitioner_${ID}_${time}.png
    Avoid Common Azure Loading Elements
    log to the console    practitioner run successfully
Validate Each Resource Folder Contains file
    [Arguments]  ${filename}
    Sleep  2s
    ${resources}=  Get WebElements  //span[@class="fx-grid-formatters-svgtext"]
    FOR  ${i}  IN  @{resources}
        Append To List   ${List}    ${i.text}
    END
    Remove Values From List  ${List}  [..]
    Log To The Console  ${List}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Resource_list_${time}.png
    FOR  ${i}  IN  @{List}
        Avoid Common Azure Loading Elements
        Log To The Console  ${i}
        IF    '${i}' != 'patient'
            ${isSubFolder}  Run Keyword And Return Status   Should not Be True  "${i}" == "[..]"
            Run Keyword If   ${isSubFolder}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : ${i} resource type file is present in the ${i} folder(DSEP Containter) of ${VSA} storage account${\n}
            Run Keyword If  not ${isSubFolder}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : ${i} resource type file is not present in the ${i} folder(DSEP Containter) of ${VSA} storage account${\n}
            Run Keyword if  ${isSubFolder}   Click Resource Capture Screenshot  ${i}  ${filename}
            Run Keyword if  ${isSubFolder}   Click Element  //span[text()='${i}_${ID}.json']
            Click Element    //span[@class='fx-grid-formatters-svgtext' and text()='[..]']
            Avoid Common Azure Loading Elements
        END
        IF    '${i}' == 'patient'
            ${isSubFolder}  Run Keyword And Return Status   Should not Be True  "${i}" == "[..]"
            Run Keyword If   ${isSubFolder}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : ${i} resource type file is present in the ${i} folder(DSEP Containter) of ${VSA} storage account${\n}
            Run Keyword If  not ${isSubFolder}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : ${i} resource type file is not present in the ${i} folder(DSEP Containter) of ${VSA} storage account${\n}
            Run Keyword if  ${isSubFolder}   Click Patient Resource Capture Screenshot  ${i}  ${dsep_id}
            Run Keyword if  ${isSubFolder}   Click Element  //span[text()='${i}_${dsep_id}.json']
            Click Element    //span[@class='fx-grid-formatters-svgtext' and text()='[..]']
            Avoid Common Azure Loading Elements
        END
    END

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
    Append To File  ${API_Output_filePath}${TC_ID}.txt  Acknowledgement JSON: ${fileACK}${\n}
    ${status6}  Run Keyword And Return Status   Should be True  "${filename}" == "${fileACK["transaction_id"]}"
    Run Keyword If   ${status6}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Transaction id is same as the File Name${\n}
    Run Keyword If  not ${status6}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Transaction id is not same as the File Name${\n}
    ${status7}  Run Keyword And Return Status   Should be True  "200" == "${fileACK["status"]}"
    Run Keyword If   ${status7}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Status is displayed as ${fileACK["status"]} in the acknowledgement json${\n}
    Run Keyword If  not ${status7}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Status is displayed as ${fileACK["status"]} in the acknowledgement json${\n}
    ${status8}  Run Keyword And Return Status   Should be True  "${fileACK["acknowledgement"]["OID"]}"  "urn:oid:2.16.840.1.113883.3.12345"
    Run Keyword If   ${status8}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : OID is displayed as ${fileACK["acknowledgement"]["OID"]}${\n}
    Run Keyword If  not ${status8}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : OID is dsiaplyed as ${fileACK["acknowledgement"]["OID"]}${\n}
    ${status9}  Run Keyword And Return Status   Should be True  "${fileACK["acknowledgement"]["DocSpera_ID"]}"  "1234325"
    Run Keyword If   ${status9}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : Docspera id is displayed as ${fileACK["acknowledgement"]["DocSpera_ID"]}${\n}
    Run Keyword If  not ${status9}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : Docspera id is displayed as ${fileACK["acknowledgement"]["DocSpera_ID"]}${\n}
    set Global Variable  ${dsep_id}  ${fileACK["acknowledgement"]["DSEP PatientID"]}
    ${status10}  Run Keyword And Return Status   Should Match Regexp  ${fileACK["acknowledgement"]["DSEP PatientID"]}  [a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}
    Run Keyword If   ${status10}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : DSEP Patient id is extracted as ${fileACK["acknowledgement"]["DSEP PatientID"]}${\n}
    Run Keyword If  not ${status10}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : DSEP Patient id is not extracted as ${fileACK["acknowledgement"]["DSEP PatientID"]}${\n}

File Should Not be Present in dlq container
    [Arguments]  ${container}  ${filename}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Sleep  5 s
    Click Element    //input[@placeholder="Search blobs by prefix (case-sensitive)"]
    Clear Filter Then Input Text    //input[@placeholder="Search blobs by prefix (case-sensitive)"]    ${filename}.json
    Sleep  5 s
    Avoid Common Azure Loading Elements
    Sleep  4s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}File_not_in_container_${time}.png
    ${status4}  Run Keyword And Return Status   Page Should not Contain Element   //span[text ()="${filename}.json"]
    Run Keyword If  ${status4}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : FHIR Bundle json file is not present in the ${container} container of ${VSA} storage account${\n}
    Run Keyword If  not ${status4}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : FHIR Bundle json file is present in the ${container} container of ${VSA} storage account${\n}
    Log To The Console  File is not in error container

File Should be Present
    [Arguments]  ${container}  ${filename}
    Click Element  //div[text ()='${container}']
    Avoid Common Azure Loading Elements
    ${status1}  Run Keyword And Return Status   Page Should Contain  ${filename}.json
    Run Keyword If   ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : FHIR Bundle json file is present in the ${container} container of ${VSA} storage account${\n}
    Run Keyword If  not ${status1}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : FHIR Bundle json file is not present in the ${container} container of ${VSA} storage account${\n}
    Click Element  //span[text()='${filename}.json']
    Avoid Common Azure Loading Elements
    Sleep  2 s
    Click Element  (//span[text()='Edit'])[1]
    Avoid Common Azure Loading Elements
    Sleep  1 s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Details_Uploaded_to_Blob_${time}.png
    Log To The Console  File Details Uploaded To Blob

File Should be Present in archieve container
    [Arguments]  ${container}  ${filename}
    Click Element  //div[text ()='${container}']
    Avoid Common Azure Loading Elements
    Log To The Console  ${filename}.json
    Sleep  5 s
    Click Element    //input[@placeholder="Search blobs by prefix (case-sensitive)"]
    Clear Filter Then Input Text    //input[@placeholder="Search blobs by prefix (case-sensitive)"]    ${filename}.json
    Sleep  5 s
    ${status3}  Run Keyword And Return Status   Page Should Contain  ${filename}.json
    Run Keyword If   ${status3}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : FHIR Bundle json file is present in the ${container} container of ${VSA} storage account${\n}
    Run Keyword If  not ${status3}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : FHIR Bundle json file is not present in the ${container} container of ${VSA} storage account${\n}
    Sleep  5 s
    Click Element  //span[text()='${filename}.json']
    Avoid Common Azure Loading Elements
    Sleep  2 s
    Click Element  (//span[text()='Edit'])[1]
    Avoid Common Azure Loading Elements
    Sleep  1 s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Details_Uploaded_to_Blob_${time}.png
    Log To The Console  File has been placed in docspera-ack container

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
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Details_Uploaded_to_Blob_${time}.png
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


Download JSON File
    Avoid Common Azure Loading Elements
    Click element  //div[contains(text(), "Download")]
    Sleep  2s
