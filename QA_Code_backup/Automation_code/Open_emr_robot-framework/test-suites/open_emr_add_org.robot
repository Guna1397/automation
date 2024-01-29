*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-217


###Author: Dayanidhi Kasi ###
Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections
Library  RequestsLibrary
Library     ../scripts/validation.py
Library     ../scripts/api_output_generation.py


Resource  Variables.robot
Resource  Locators.robot
Resource  CommonKeywords.robot
Resource  Support_API.robot

#Suite Setup         Initialize Docspera Variables
#Test Setup          Create API Output Tag List
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
## TC02
Add Patient details from DOCSPERA to DSP
    [Tags]      JAYU-293
#    Given User is logged into Azure & user has required Subscription
    Given User is logged into openemr portal
    When create facility on opememr portal
#    When User uploads a file in docspera-adls container of Docspera storage account  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}
#    Then User validates that file is moved from docspera-adls container of Docspera storage account  ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][1]}  ${DocsperaFile1}.json
#    And User validates that file is archived in docpsera-archive container of Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][2]}
#    And User validates that file is not present in dlq container of Velys storage account   ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][4]}
#    And User validate that acknowledgement is saved in docspera-ack container of Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][3]}    ${VSA}
#    And User validates patient details are organied in resource folders in dsep container of Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][0]}
#    And User validate that acknowledgment is archived in docspera-ack-archive container of Velys storage account  ${docsperaSA[1]["name"]}  ${docsperaSA[3]["container"][8]}    ${VSA}
#    And User validate that acknowledgement is sent to docspera-ack container of DocSpera storage account    ${docsperaSA[2]["name"]}  ${docsperaSA[3]["container"][3]}      ${DSA}


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

User is logged into openemr portal
    Initialize open emr Variables
    User Launches openemr Portal
    User Enters Valid Credentials

User Enters Valid Credentials
    sleep  5
    Click Element  //input[@placeholder='Username']
    Wait Until Element Is Visible  //input[@placeholder='Username']  ${Wait}
    Input Text  //input[@placeholder='Username']  ${username}
    Click Element  //input[@placeholder='Password']
    Input Password  //input[@placeholder='Password']  ${password}
    sleep  5
    Wait Until Element Is Visible  //button[@class='btn btn-primary' and text()='Login']  ${Wait}
    Log To Console  UserName and Password verified Successfully
    Click Element  //button[@class='btn btn-primary' and text()='Login']
    sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Opememr_Home_Page_${time}.png
    Retry Page

Initialize open emr Variables
    ${json}  Get file  ${basejsonfilepath}test_data.json
    ${testData}  Evaluate  json.loads('''${json}''')  json

    set Global Variable  ${openemrurl}  ${testData["openemr_base_url"]}
    set Global Variable   ${user_name}    ${testData["username"]}
    set Global Variable   ${password}    ${testData["password"]}
    set Global Variable   ${facilityname}    ${testData["facilityname"]}
    set Global Variable   ${country}    ${testData["country"]}
    set Global Variable   ${email}    ${testData["email"]}
    set Global Variable   ${color}    ${testData["color"]}

User Launches openemr Portal
    Configure Selenium Speed  0.35 s
    Initialize Browser With Custom Download Directory open
     Open Browser  ${openemrurl}  chrome
#     ...         set_preference("browser.download.dir", r"${DownloadDir}"")
    Set Window Size  1600  1200
    Retry Page

Initialize Browser With Custom Download Directory open
    # ${downloadDir}  Join Path  .${/}  downloads_robot
    Create Directory  ${DownloadDir}
    ${chromeOptionsVar}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    ${pref}  Create Dictionary  download.default_directory=${downloadDir}
    Call Method  ${chromeOptionsVar}  add_experimental_option  prefs  ${pref}
    Call Method    ${chromeOptionsVar}    add_argument    --headless
    Create Webdriver  Chrome  chrome_options=${chromeOptionsVar}
    Goto  ${openemrurl}

create facility on opememr portal
    Click Element    //div[@class='menuLabel px-1 dropdown-toggle oe-dropdown-toggle' and text()='Admin']
    Sleep    2s
    Click Element    //div[@class='menuLabel px-1 dropdown-toggle oe-dropdown-toggle' and text()='Clinic']
    Sleep    2s
    Click Element    //div[@class='menuLabel px-1' and text()='Facilities']
    Sleep    2s
    Select Frame    //iframe[@name="adm"]
    Sleep    2s
    Click Element    //*[@href="facilities_add.php" and text()="Add Facility"]
    Sleep    5s
    Unselect Frame
#    Click Element    //div[@class="modal-dialog drag-action modal-custom-526ff0311a06c7ac3fdf4725749e116b"]
    Sleep    2s
    Select Frame    //iframe[@class="modalIframe w-100 h-100 border-0"]
    Current Frame Should Contain  Add Facility
    Sleep    2s
    Click Element    //input[@class="form-control" and @name="facility"]
    Input Text  //input[@class="form-control" and @name="facility"]     ${facilityname}
    Sleep    2s
    Click Element    //input[@class="form-control" and @name="country_code"]
    Input Text    //input[@class="form-control" and @name="country_code"]   ${country}
    Sleep    2s
    Click Element    //input[@class="form-control" and @name="email"]
    Input Text    //input[@class="form-control" and @name="email"]    ${email}
    Sleep    2s
    Click Element    //input[@class="form-control" and @name="ncolor"]
    Input Text    //input[@class="form-control" and @name="ncolor"]     ${color}
    Sleep    2s
    Click Element    //label[@for="billing_location"]
    Sleep    2s
    Click Element    //label[@for="accepts_assignment"]
    Sleep    2s
    Click Element    //label[@for="service_location"]
    Sleep    1s
    Click Element    (//button[@class="btn btn-primary btn-save" and @name="form_save"])[1]
    Sleep    5s
    Select Frame    //iframe[@name="adm"]
    Sleep    2s
    Click Element    //span[text()="${facilityname}"]
    Log To The Console    Facility added successfully
    Sleep    2s
    Unselect Frame
#    Log To The Console    Frame Unselected
    Sleep    2s
    Select Frame    //iframe[@class="modalIframe w-100 h-100 border-0"]
#    Log To The Console    Frame selected
    Sleep    2s
    CLick Element    (//a[@id="cancel"])[1]
    Unselect Frame

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

Download JSON File
    Avoid Common Azure Loading Elements
    Click element  //div[contains(text(), "Download")]
    Sleep  2s
