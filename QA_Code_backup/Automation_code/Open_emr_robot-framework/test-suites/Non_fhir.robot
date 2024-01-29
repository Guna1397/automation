*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-243


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

Suite Setup          Run Keywords  Remove Output files  Initialize Docspera Variables
Test Setup           Create API Output Tag List
#Test Teardown       User has a Valid API Response
#Suite Teardown      Close All Browsers

*** Variables ***
${HSDI_M_SACnt}
${env}
${DocsperaFile1}=    1b02e041-53dd-4e72-ae2c-959db7476bb6
${DownloadDir}=  ${CURDIR}/downloads_robot/
${BaseURL}=  https://filescanner-api.api-apd-afl.thesurgicalnet.com
${dsep_id}
${ID}
${workDir}
@{List}

*** Test Cases ***
##TC01
Validate Non FHIR checklist json is processed from docspera and moved to Velys storage account
     [Tags]      JAYU-252
     Given User is logged into Azure & user has required Subscription
     When User uploads a checklist file in dsep container of Docspera storage account  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][0]}    checklist
     Then User validates Checklist file is NOT present in dsep container of DocSpera storage account
     And User validates the file is moved to Checklist Folder of dsep container in Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][0]}    checklist    ${DocsperaFile1}

##TC02
Validate Non FHIR intake json is processed from docspera and moved to Velys storage account
     [Tags]      JAYU-253
     Given User is logged into Azure & user has required Subscription
     When User uploads a intake file in dsep container of Docspera storage account      ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][0]}    intake
     Then User validates Intake file is NOT present in dsep container of DocSpera storage account
     And User validates the file is moved to Intake Folder of dsep container in Velys storage account     ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][0]}    intake    ${DocsperaFile1}

##TC03
Validate Non FHIR intake smart scheduler json is processed from docspera and moved to Velys storage account
     [Tags]      JAYU-254
     Given User is logged into Azure & user has required Subscription
     When User uploads a Intake-Smart-Scheduler file in dsep container of Docspera storage account        ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][0]}      intake_smart_scheduler
     Then User validates Intake-Smart-Scheduler file is NOT present in dsep container of DocSpera storage account
     And User validates the file is moved to Intake-Smart-Scheduler Folder of dsep container in Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][0]}    intake_smart_scheduler    ${DocsperaFile1}

*** Keywords ***
Initialize Docspera Variables
    ${json}  Get file  ${basejsonfilepath}docspera-storage-accounts_RobotTest.json
    ${DS}  Evaluate  json.loads('''${json}''')  json
    set Global Variable  ${DocsperaSA}  ${DS}
    set Global Variable   ${DSA}    ${DocsperaSA[2]["name"]}
    set Global Variable   ${VSA}    ${DocsperaSA[1]["name"]}
    ${Bundlejson}  Get file  ../dsp_daa_fhir_layering/configurationfiles/${env}/testdata/${DocsperaFile1}.json
    ${Bundle}  Evaluate  json.loads('''${Bundlejson}''')  json
    set Global Variable  ${ID}  ${Bundle["entry"][0]["resource"]["id"]}

User uploads a checklist file in dsep container of Docspera storage account
    [Arguments]  ${sa_name}  ${container_name}  ${folderName}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Upload a File  ${container_name}  ${DocsperaFile1}.json     ${folderName}

User validates Checklist file is NOT present in dsep container of DocSpera storage account
    File NOT present in dsep container of DocSpera storage account    ${DocsperaFile1}   checklist

User validates the file is moved to Checklist Folder of dsep container in Velys storage account
    [Arguments]  ${sa_name}  ${container_name}    ${folderName}    ${filename}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Navigate to v2 checklist folder of dsep container Directory  ${container_name}    ${folderName}    ${filename}

User uploads a intake file in dsep container of Docspera storage account
    [Arguments]  ${sa_name}  ${container_name}  ${folderName}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Upload a File  ${container_name}  ${DocsperaFile1}.json     ${folderName}

User validates Intake file is NOT present in dsep container of DocSpera storage account
    File NOT present in dsep container of DocSpera storage account    ${DocsperaFile1}  intake

User validates the file is moved to Intake Folder of dsep container in Velys storage account
    [Arguments]  ${sa_name}  ${container_name}    ${folderName}    ${filename}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Navigate to v2 checklist folder of dsep container Directory  ${container_name}    ${folderName}    ${filename}

User uploads a Intake-Smart-Scheduler file in dsep container of Docspera storage account
    [Arguments]  ${sa_name}  ${container_name}  ${folderName}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Upload a File  ${container_name}  ${DocsperaFile1}.json     ${folderName}

User validates Intake-Smart-Scheduler file is NOT present in dsep container of DocSpera storage account
    File NOT present in dsep container of DocSpera storage account    ${DocsperaFile1}  intake_smart_scheduler

User validates the file is moved to Intake-Smart-Scheduler Folder of dsep container in Velys storage account
    [Arguments]  ${sa_name}  ${container_name}    ${folderName}    ${filename}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Navigate to v2 checklist folder of dsep container Directory  ${container_name}    ${folderName}    ${filename}

Navigate to Docspera Storage account Blob container
    [Arguments]  ${storageAcc}
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text  ${AZSearch}  ${storageAcc}
    Click Element  //div[text ()='${storageAcc}']
    Avoid Common Azure Loading Elements
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  StorageAcc-${storageAcc}_Overview_${time}.png
    Wait Until Element Is Visible  //*[text()='Containers']  ${Wait}
    Avoid Common Azure Loading Elements
    Click Element  //*[text()='Containers']
    Avoid Common Azure Loading Elements
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  DocSpera_Storage_Account_Blob_${time}.png
    Log To The Console  DocSpera Storage Account Contains a Blob Service

Navigate to v2 checklist folder of dsep container Directory
    [Arguments]  ${container}    ${folderName}    ${filename}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Sleep    2s
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text    //input[@placeholder="Search blobs by prefix (case-sensitive)"]    v1/2.16.840.1.113883.3.12345/non-fhir/${folderName}/${filename}
    Sleep  3
    ${status5}  Run Keyword And Return Status   Page Should Contain  ${DocsperaFile1}.json
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Velys_DsepContainer_V2_${folderName}_Folder_${time}.png


Upload a File
    [Arguments]  ${container}  ${filename}    ${folderName}
    Sleep  10
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${container}_Screen_${time}.png
    Sleep  3
    Click Element  //div[text ()='Upload']
    Avoid Common Azure Loading Elements
    Sleep  2
    Wait Until Element Is Visible  //h2[text()='Upload blob']  ${Wait}
    Sleep  2
    Log To Console    ${workDir}
    Choose File     ${File_upload_Field}     ${workDir}/dsp_daa_fhir_layering/configurationfiles/${env}/testdata/${filename}
    Sleep  2
    Click Element    //div[text()='Advanced']
    sleep   2
    Wait Until Element Is Visible    (//label[text()='Upload to folder']//following::input)[1]    ${Wait}
    sleep    2
    Clear Filter Then Input Text    (//label[text()='Upload to folder']//following::input)[1]    v1/2.16.840.1.113883.3.12345/non-fhir/${folderName}
    Sleep    2
    Wait Until Element Is Visible  ${Upload_Button}  ${Wait}
    Click Element  ${Upload_Button}
    Log To Console    File has been successfully uploaded
    Avoid Common Azure Loading Elements
    Clear Filter Then Input Text    //input[@placeholder="Search blobs by prefix (case-sensitive)"]    v1/2.16.840.1.113883.3.12345/non-fhir/${folderName}/
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${folderName}_${filename}_File_Upload_Completed_${time}.png
    ${status5}  Run Keyword And Return Status   Page Should Contain  //span[text()='${filename}.json']


File NOT present in dsep container of DocSpera storage account
    [Arguments]  ${filename}  ${folderName}
    Click Element  //h2[text()="Upload blob"]//following::button[@title="Close"]
    Sleep  15
    Click Element  //h2[text()='dsep']//following::div[text()='Refresh']
    Sleep  10
    Page Should Not Contain   //span[text()='${filename}.json']
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  DocSpera_StorageAcc_${folderName}_File_${filename}_Not_Present_${time}.png