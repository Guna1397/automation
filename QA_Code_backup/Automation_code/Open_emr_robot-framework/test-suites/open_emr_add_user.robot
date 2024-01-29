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
    Given User is logged into openemr portal
    When create practitioner on opememr portal

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
    ${json}    Get file  ${basejsonfilepath}test_data.json
    ${testData}   Evaluate  json.loads('''${json}''')  json
    set Global Variable   ${testData}
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

create practitioner on opememr portal
    Wait Until Element Is Visible  //div[@class='menuLabel px-1 dropdown-toggle oe-dropdown-toggle' and text()='Admin']
    Click Element  //div[@class='menuLabel px-1 dropdown-toggle oe-dropdown-toggle' and text()='Admin']
    Wait Until Element Is Visible  //div[@class='menuLabel px-1' and text()='Users']
    Click Element  //div[@class='menuLabel px-1' and text()='Users']
    Select Frame    //iframe[@name="adm"]
    Wait Until Element Is Visible  //a[@href="usergroup_admin_add.php"]
    Click Element  //a[@href="usergroup_admin_add.php"]
    Sleep  2s
    Unselect Frame
    Sleep  2s
    Select Frame    //*[@id="modalframe"]
    Wait Until Element Is Visible  //input[@name="rumple"]
    Click Element  //input[@name="rumple"]
    Input Text   //input[@name="rumple"]    ${testData["adduser"]["username"]}   50s           ##Parameter
    Wait Until Element Is Visible  //input[@type="password"]
    Click Element  //input[@type="password"]
    Input Text   //input[@type="password"]    ${testData["adduser"]["password"]}     50s                ##Parameter
    Wait Until Element Is Visible  //input[@name="adminPass"]
    Click Element  //input[@name="adminPass"]
    Input Text   //input[@name="adminPass"]    ${testData["adduser"]["yourpass"]}    50s                  ##Parameter
    Wait Until Element Is Visible  //input[@name="fname"]
    Click Element  //input[@name="fname"]
    Input Text   //input[@name="fname"]     ${testData["adduser"]["fname"]}   50s                 ##Parameter
    Wait Until Element Is Visible  //input[@name="lname"]
    Click Element  //input[@name="lname"]
    Input Text   //input[@name="lname"]     ${testData["adduser"]["lname"]}   50s                  ##Parameter
    Wait Until Element Is Visible  //input[@type="checkbox" and @name="authorized"]
    Click Element  //input[@type="checkbox" and @name="authorized"]
    Wait Until Element Is Visible  //input[@name="portal_user"]
    Click Element  //input[@name="portal_user"]
    Wait Until Element Is Visible  //select[@name="facility_id"]
    Click Element  //select[@name="facility_id"]
#    //select[@name="facility_id"]/option[text()="Your Clinic Name Here"]
#    Wait Until Element Is Visible  //*[@id="new_user"]/table/tbody/tr[6]/td[4]/select/option[23]
#    Click Element  //*[@id="new_user"]/table/tbody/tr[6]/td[4]/select/option[23]
    Wait Until Element Is Visible  //select[@name="facility_id"]//option[text()="${testData["facilityname"]}"]
    Click Element  //select[@name="facility_id"]//option[text()="${testData["facilityname"]}"]
    Wait Until Element Is Visible  //select[@name="see_auth"]
    Click Element  //select[@name="see_auth"]
    Wait Until Element Is Visible  //*[@id="new_user"]/table/tbody/tr[8]/td[4]/select/option[3]
    Click Element  //*[@id="new_user"]/table/tbody/tr[8]/td[4]/select/option[3]
    Wait Until Element Is Visible  //select[@name="billing_facility_id"]
    Click Element  //select[@name="billing_facility_id"]
    Wait Until Element Is Visible  //select[@name="billing_facility_id"]//option[text()="${testData["facilityname"]}"]
    Click Element  //select[@name="billing_facility_id"]//option[text()="${testData["facilityname"]}"]
    Wait Until Element Is Visible  //select[@name="physician_type"]
    Click Element  //select[@name="physician_type"]
    Wait Until Element Is Visible  //select[@name="physician_type"]//option[text()="Physician"]
    Click Element  //select[@name="physician_type"]//option[text()="Physician"]
    Wait Until Element Is Visible  //select[@name="supervisor_id"]
    Click Element  //select[@name="supervisor_id"]
    Wait Until Element Is Visible  //select[@name="supervisor_id"]//option[text()="Administrator Administrator "]
    Click Element  //select[@name="supervisor_id"]//option[text()="Administrator Administrator "]
    Wait Until Element Is Visible  //select[@name="erxrole"]
    Click Element  //select[@name="erxrole"]
    Wait Until Element Is Visible  //select[@name="erxrole"]//option[text()="NewCrop Doctor"]
    Click Element  //select[@name="erxrole"]//option[text()="NewCrop Doctor"]
    Wait Until Element Is Visible  //a[@name="form_save"]
    Click Element  //a[@name="form_save"]

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
