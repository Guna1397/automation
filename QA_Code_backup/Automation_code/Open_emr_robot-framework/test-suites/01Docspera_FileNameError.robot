*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-219


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
${HSDI_M_SACnt}  0
${DocsperaFile_NameError}=  1cf28b76s-5df4s-4508s-a9ce-4165df439748-filenameerror
${DocsperaFile_JsonStructureError}=    1dfab9a9-88be-436b-86cb-66f8583f3d06
${DownloadDir}=  ${CURDIR}/downloads_robot/
${BaseURL}=  https://filescanner-api.api-apd-afl.thesurgicalnet.com
@{item}
${workDir}

*** Test Cases ***
##TC01
Error Processing for File name
    [Tags]   Docspera    JAYU-298
    Initialize Docspera Variables
    Given User is logged into Azure & user has required Subscription
    When User uploads a filename error file in docspera-adls container of DocSpera SA  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}
    Then User validates that file is not present in docspera-adls container of DocSpera SA  ${DocsperaFile_NameError}.json
    And User Validate the filename error File is present in the docspera-dlq container of Velys SA  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][4]}

##TC02
Error Processing for Invalid Json structure
    [Tags]   Docspera    JAYU-306
    Initialize Docspera Variables
    Given User is logged into Azure & user has required Subscription
    When User uploads a json structure error file in docspera-adls container of DocSpera SA  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}
    Then User validates that file is not present in docspera-adls container of DocSpera SA  ${DocsperaFile_JsonStructureError}.json
    And User Validate json structure error File is present in docspera-dlq container of Velys SA   ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][4]}

*** Keywords ***
Initialize Docspera Variables
     ${json}  Get file  ${basejsonfilepath}docspera-storage-accounts_RobotTest.json
    ${DS}  Evaluate  json.loads('''${json}''')  json
    set Global Variable  ${DocsperaSA}  ${DS}
    set Global Variable   ${DSA}    ${DocsperaSA[2]["name"]}
    set Global Variable   ${VSA}    ${DocsperaSA[1]["name"]}
    ${Bundlejson}  Get file  ../dsp_daa_fhir_layering/configurationfiles/${env}/testdata/1b02e041-53dd-4e72-ae2c-959db7476bb6.json
    ${Bundle}  Evaluate  json.loads('''${Bundlejson}''')  json
    set Global Variable  ${ID}  ${Bundle["entry"][0]["resource"]["id"]}

User uploads a filename error file in docspera-adls container of DocSpera SA
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    Upload a File  ${container_name}  ${DocsperaFile_NameError}.json

User validates that file is not present in docspera-adls container of DocSpera SA
    [Arguments]  ${filename}
    Sleep  10s
    Click Element  (//div[text ()='Refresh'])[2]
    Avoid Common Azure Loading Elements
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_Not_Present_in_DocSpera_Storage_Account_Blob_${time}.png
    ${status}  Run Keyword And Return Status   Page Should Not Contain  ${filename}
    ${time}  Get current date
    Log to console    ${status}
    Run Keyword If   ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : FHIR Bundle json file is processed from docspera-adls container of ${DSA} storage account${\n}
    Run Keyword If  not ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : FHIR Bundle json file is not processed from docspera-adls container of ${DSA} storage account${\n}
    Avoid Common Azure Loading Elements

User Validate the filename error File is present in the docspera-dlq container of Velys SA
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Docspera Storage account Blob container  ${sa_name}
    File Should be Present in dlq container  ${container_name}  ${DocsperaFile_NameError}

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
    Capture Page Screenshot  ${storageAcc}_Device_Storage_Account_Blob_${time}.png
    Log To The Console  Device Storage Account Contains a Blob Service

Click Resource Capture Screenshot
    [Arguments]  ${resourceName}  ${filename}
        Avoid Common Azure Loading Elements
        Click Element  //span[text()="${resourceName}"]
        Avoid Common Azure Loading Elements
        Page Should Contain  ${resourceName}_${filename}.json
        Click Element  //span[text()="${resourceName}_${filename}.json"]
        Avoid Common Azure Loading Elements
        Sleep  1s
        Click Element  (//span[text()='Edit'])[1]
        Avoid Common Azure Loading Elements
        Sleep  1s
        ${resource}  get_captialized  ${resourceName}
        Page Should Contain  ${resource}
        # Page Should Contain
        ${time}  Get current date
        ${time}  convert date  ${time}  result_format= %H%M%S
        Capture Page Screenshot  Resource_Folder_${resourceName}_${time}.png


File Should be Present in dlq container
    [Arguments]  ${container}  ${filename}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Avoid Common Azure Loading Elements
    Sleep  4s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_not_in_container_${time}.png
    Page Should Contain Element   //span[text ()="${filename}.json"]
    Click Element  //span[text ()="${filename}.json"]
    Sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Details_${time}.png
    Log To The Console  File is present in error container
    Sleep    10s
    ${status}  Run Keyword And Return Status   Page Should Contain Element   //span[text ()="${filename}.json"]
    ${time}  Get current date
    Log to console    ${status}
    Run Keyword If   ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : FHIR Bundle json file ${filename} is present in dlq container of ${VSA} storage account${\n}
    Run Keyword If  not ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : FHIR Bundle json file ${filename} is not present in dlq container of ${VSA} storage account${\n}
    Avoid Common Azure Loading Elements

Upload a File
    [Arguments]  ${container}  ${filename}
    Sleep  5
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Sleep  8
    Click Element  //div[text ()='Upload']
    Avoid Common Azure Loading Elements
    Sleep  8
    Wait Until Element Is Visible  //h2[text()='Upload blob']  ${Wait}
    Sleep  8
    Choose File     ${File_upload_Field}     ${workDir}/dsp_daa_fhir_layering/configurationfiles/${env}/testdata/${filename}
    Sleep  8
    Click Element  ${Upload_Button}
    Avoid Common Azure Loading Elements
    Log To Console    ${CURDIR}${/}
    Sleep  4s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Upload_Completed_${time}.png
    Click Element  //h2[text()='Upload blob']/following-sibling::div/button[@title='Close']




Download JSON File
    Avoid Common Azure Loading Elements
    Click element  //div[contains(text(), "Download")]
    Sleep  2s

User uploads a json structure error file in docspera-adls container of DocSpera SA
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Docspera Storage account Blob container Syntax Error  ${sa_name}
    Upload a File Syntax Error  ${container_name}  ${DocsperaFile_JsonStructureError}.json

User Validate json structure error File is present in docspera-dlq container of Velys SA
    [Arguments]  ${sa_name}  ${container_name}
    Navigate to Docspera Storage account Blob container Syntax Error  ${sa_name}
    File Should be Present in dlq container Syntax Error    ${container_name}  ${DocsperaFile_JsonStructureError}

Navigate to Docspera Storage account Blob container-Syntax_Error
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
    Capture Page Screenshot  Device_Storage_Account_Blob_${time}.png
    Log To The Console  Device Storage Account Contains a Blob Service

File Should be Present in dlq container Syntax Error
    [Arguments]  ${container}  ${filename}
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Avoid Common Azure Loading Elements
    Sleep  2s
    ${status}  Run Keyword And Return Status   Page Should Contain Element   //span[text ()="${filename}.json"]
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}error_File_is_in_container_${time}.png
    Click Element   //span[text ()="${filename}.json"]
    Sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Details_${time}.png
    Log To The Console  File is in error container
    Run Keyword If   ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  PASS : FHIR Bundle json file ${filename} is present in dlq container of ${VSA} storage account${\n}
    Run Keyword If  not ${status}    Append To File  ${API_Output_filePath}${TC_ID}.txt  FAIL : FHIR Bundle json file ${filename} is not present in dlq container of ${VSA} storage account${\n}
    Avoid Common Azure Loading Elements

Navigate to Docspera Storage account Blob container Syntax Error
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
    Capture Page Screenshot  Device_Storage_Account_Blob_${time}.png
    Log To The Console  Device Storage Account Contains a Blob Service

Upload a File Syntax Error
    [Arguments]  ${container}  ${filename}
    Sleep  5
    Click Element  //div[text ()='${container}']
    Wait Until Element Is Visible  //h2[text()='${container}']  ${Wait}
    Sleep  8
    Click Element  //div[text ()='Upload']
    Avoid Common Azure Loading Elements
    Sleep  8
    Wait Until Element Is Visible  //h2[text()='Upload blob']  ${Wait}
    Sleep  8
    Choose File     ${File_upload_Field}     ${workDir}/dsp_daa_fhir_layering/configurationfiles/${env}/testdata/${filename}
    Sleep  8
    Click Element  ${Upload_Button}
    Avoid Common Azure Loading Elements
    Log To Console    ${CURDIR}${/}
    Sleep  4s
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${filename}_File_Upload_Completed_${time}.png
    Sleep  10
    Click Element  //h2[text()='Upload blob']/following-sibling::div/button[@title='Close']
    Avoid Common Azure Loading Elements
    Page Should Contain  ${filename}
    Sleep  30s
    Click Element  (//div[text ()='Refresh'])[2]
    Avoid Common Azure Loading Elements
    Sleep  5s
    Avoid Common Azure Loading Elements



