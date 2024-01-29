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
${firstname}
${lastmane}
${dob}
${gender}
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
    When create patient on opememr portal
    Then create Encounter on opememr portal
    And create Condition on opememr portal
    And create immunizations on opememr portal

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
    set Global Variable    ${testData}
    set Global Variable  ${openemrurl}  ${testData["openemr_base_url"]}
    set Global Variable   ${user_name}    ${testData["username"]}
    set Global Variable   ${password}    ${testData["password"]}

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

create patient on opememr portal
    Click Element    //div[@class='menuLabel px-1 dropdown-toggle oe-dropdown-toggle' and text()='Patient']
    Sleep    2s
    Click Element    //div[@class="menuLabel px-1" and text()="New/Search"]
    Sleep    2s
    Select Frame    //iframe[@data-bind="location: $data, iframeName: $data.name, " and @name="pat"]
    Click Element   //form[@action="new_comprehensive_save.php"]
    Sleep    2s
    Click Element     (//div[@class="container-xl card-body"])[1]
    Sleep    1s
    Click Element    //input[@name="form_fname"]
    Input Text    //input[@name="form_fname"]   ${testData["addpatient"]["fname"]}       ##Parameter
    Sleep    2s
    Click Element    //input[@name="form_lname"]
    Input Text    //input[@name="form_lname"]   ${testData["addpatient"]["lname"]}       ##Parameter
    Sleep    2s
    Wait Until Element Is Visible  //input[@title="Date of Birth"]
    Click Element  //input[@title="Date of Birth"]
    Input Text   //input[@title="Date of Birth"]    ${testData["addpatient"]["dob"]}         ##Parameter
    Wait Until Element Is Visible  //select[@name="form_sex"]
    Click Element  //select[@name="form_sex"]
    Wait Until Element Is Visible  //select[@name="form_sex"]/option[text()="${testData["addpatient"]["gender"]}"]        ##Parameter
    Click Element  //select[@name="form_sex"]/option[text()="${testData["addpatient"]["gender"]}"]        ##Parameter
    Sleep   2s
    Click Element     (//button[@class="btn btn-link btn-block text-light text-left"])[1]
    Sleep    1s
    Click Element    (//button[@class="btn btn-link btn-block text-light text-left"])[2]
    Sleep    2s
    Click Element    //select[@name="form_providerID"]//option[text()="${testData["addpatient"]["providername"]}"]         ##Parameter
    Sleep    2s

    Click Element    //select[@class="form-control form-control-sm mw-100 select-dropdown select2-hidden-accessible"]//option[text()="${testData["addpatient"]["providername"]}"]       #careteam
    Click Element    (//input[@class="select2-search__field"]//following::option[text()= "${testData["facilityname"]}"])[1]        ##Parameter
#    Click Element    //ul[@class="select2-selection__rendered"]
#    Click Element    //span[@class="select2-container select2-container--bootstrap4 select2-container--open"]//span//span//ul//li[text()="${testData["facilityname"]}"]         #careteamfacility
    Sleep    2s
    Click Element     (//button[@class="btn btn-link btn-block text-light text-left"])[2]
    Sleep    2s
    Click Element    (//button[@class="btn btn-link btn-block text-light text-left"])[6]
    Sleep    2s
    Click Element  (//button[@class="btn btn-link btn-block text-light text-left"])[3]
    Sleep    2s
    Click Element  //select[@name="i1provider"]//option[text()="LombardGC"]        ##Parameter
    Sleep    2s
    Click Element  //input[@class="form-control" and @name="i1plan_name"]
    Input Text   //input[@class="form-control" and @name="i1plan_name"]   ${testData["addpatient"]["InsurancePlanname"]}       ##Parameter
    Sleep    2s
    Click Element  //select[@name="form_i1subscriber_relationship"]//option[text()="${testData["addpatient"]["Insurancerelationship"]}"]
    Sleep    2s
    Click Element   //button[@class="btn btn-primary btn-save"]
    Sleep    2s
    Unselect Frame
    Sleep     2s
    Select Frame    //iframe[@class="modalIframe w-100 h-100 border-0"]
    Sleep    5s
    Click Element    //input[@value="Confirm Create New Patient"]
    Sleep    20s
#    Press Keys    None    ESC
#    Click Element    //a[contains(text(),'OK']
    Handle Alert

create Encounter on opememr portal
    Click Element    //a[@title="New Encounter"]/i[@class="fa fa-plus"]
    Sleep    5s
    Select Frame    //iframe[@name="enc"]
    Sleep    2s
    Click Element    (//select[@name="pc_catid"]//following::option[text()= "${testData["addpatient"]["encountervisitcatagory"]}"])[1]        ##Parameter
    Click Element    (//select[@name="class_code"]/option[text()= "${testData["addpatient"]["encounterclass"]}"])         ##Parameter
    Click Element    (//select[@name="form_sensitivity"]/option[text()= "${testData["addpatient"]["encountersensitivity"]}"])        ##Parameter
    Click Element    (//input[@name="form_date"])
    Input Text    (//input[@name="form_date"])    ${testData["addpatient"]["encounterformdate"]}         ##Parameter
    Click Element    (//input[@name="form_onset_date"])
    Input Text    (//input[@name="form_onset_date"])    ${testData["addpatient"]["encounteronsetdate"]}        ##Parameter
    CLick Element    (//select[@name="provider_id"]/option[text()= "${testData["addpatient"]["encounterprovidername"]}"])      ##Parameter
    Click Element    (//select[@name="referring_provider_id"]/option[text()= "${testData["addpatient"]["encounterreferringprovider"]}"])      ##Parameter
    Click Element    (//select[@name="facility_id"]/option[text()= "${testData["facilityname"]}"])      ##Parameter
    Click Element    (//button[@class="btn btn-primary btn-save"])
    Unselect Frame

create Condition on opememr portal
    Click Element    //div[@class='menuLabel px-1 dropdown-toggle oe-dropdown-toggle' and text()='Popups']
    Sleep    2s
    Click Element    //div[@class='menuLabel px-1' and text()='Issues']
    Sleep    2s
    Select Frame    //iframe[@name="menupopup"]
    Sleep    2s
    ## Condition
    Click Element    //button[@class='btn btn-primary btn-sm btn-add']
    Unselect Frame
    Sleep    1s
    Select Frame    //iframe[@src="https://dev-dsp-open-emr.azurewebsites.net/interface/patient_file/summary/add_edit_issue.php"]
    Click Element    (//select[@name="form_titles"]/option[text()= "${testData["addpatient"]["conditiontitle"]}"])      ##Parameter
    Click Element    (//input[@name="form_title"])
#    Input Text    (//input[@name="form_title"])    Problem       ##Parameter
    Click Element    (//select[@name="form_verification"]/option[text()= "${testData["addpatient"]["conditionverificationstatus"]}"])       ##Parameter
#    Input Text    (//select[@name="form_verification"]/option[text()= "Refuted"])       ##Parameter
    Click Element    (//textarea[@name="form_comments"])
    Input Text    (//textarea[@name="form_comments"])    ${testData["addpatient"]["conditioncomments"]}       ##Parameter
    Click Element    (//button[@name="form_save"])
    ## AllergyIntolerance
    Select Frame    //iframe[@name="menupopup"]
    Click Element    //button[@class='btn btn-primary btn-sm btn-add']
    Unselect Frame
    Sleep    1s
    Select Frame    //iframe[@src="https://dev-dsp-open-emr.azurewebsites.net/interface/patient_file/summary/add_edit_issue.php"]
    Click Element    //input[@onclick='newtype(1)']
    Click Element    (//select[@name="form_titles"]/option[text()= "${testData["addpatient"]["allergytitle"]}"])       ##Parameter
#    Click Element    (//input[@name="form_begin"])
#    Input Text    (//input[@name="form_begin"])    2022-10-28 19:40
#    Click Element    (//input[@name="form_end"])
#    Input Text    (//input[@name="form_end"])    2022-10-28 20:40
    Click Element    (//select[@name="form_reaction"]/option[text()= "${testData["addpatient"]["allergyreaction"]}"])       ##Parameter
    Click Element    (//textarea[@name="form_comments"])
    Input Text    (//textarea[@name="form_comments"])    ${testData["addpatient"]["conditioncomments"]}        ##Parameter
    Click Element    (//button[@name="form_save"])
#    Click Element    //button[@class='btn btn-primary btn-sm btn-add']
    ## Medication
    Select Frame    //iframe[@name="menupopup"]
    Click Element    //button[@class='btn btn-primary btn-sm btn-add']
    Unselect Frame
    Sleep    1s
    Select Frame    //iframe[@src="https://dev-dsp-open-emr.azurewebsites.net/interface/patient_file/summary/add_edit_issue.php"]
    Click Element    //input[@onclick='newtype(2)']
    Click Element    (//select[@name="form_titles"]/option[text()= "Metformin"])       ##Parameter
#    Click Element    (//input[@name="form_begin"])
#    Input Text    (//input[@name="form_begin"])    2022-10-28 19:40
#    Click Element    (//input[@name="form_end"])
#    Input Text    (//input[@name="form_end"])    2022-10-28 20:40
    Click Element    (//textarea[@name="form_comments"])
    Input Text    (//textarea[@name="form_comments"])    Test       ##Parameter
    Click Element    (//button[@name="form_save"])
    ## Medication
    Select Frame    //iframe[@name="menupopup"]
    Click Element    //button[@class='btn btn-primary btn-sm btn-add']
    Unselect Frame
    Sleep    1s
    Select Frame    //iframe[@src="https://dev-dsp-open-emr.azurewebsites.net/interface/patient_file/summary/add_edit_issue.php"]
    Click Element    //input[@onclick='newtype(3)']
    Click Element    (//input[@name="form_title"])
    Input Text    (//input[@name="form_title"])    Device       ##Parameter
#    Click Element    (//input[@name="form_begin"])
#    Input Text    (//input[@name="form_begin"])    2022-10-28 19:40
#    Click Element    (//input[@name="form_end"])
#    Input Text    (//input[@name="form_end"])    2022-10-28 20:40
    Click Element    (//textarea[@name="form_comments"])
    Input Text    (//textarea[@name="form_comments"])    Test       ##Parameter
    Click Element    (//button[@name="form_save"])
    ## Surgery
    Select Frame    //iframe[@name="menupopup"]
    Click Element    //button[@class='btn btn-primary btn-sm btn-add']
    Unselect Frame
    Sleep    1s
    Select Frame    //iframe[@src="https://dev-dsp-open-emr.azurewebsites.net/interface/patient_file/summary/add_edit_issue.php"]
    Click Element    //input[@onclick='newtype(4)']
    Click Element    (//select[@name="form_titles"]/option[text()= "tonsillectomy"])        ##Parameter
#    Click Element    (//input[@name="form_begin"])
#    Input Text    (//input[@name="form_begin"])    2022-10-28 19:40
#    Click Element    (//input[@name="form_end"])
#    Input Text    (//input[@name="form_end"])    2022-10-28 20:40
    Click Element    (//textarea[@name="form_comments"])
    Input Text    (//textarea[@name="form_comments"])    Test        ##Parameter
    Click Element    (//button[@name="form_save"])
    Select Frame    //iframe[@name="menupopup"]
    Click Element    (//button[@class="btn btn-secondary btn-sm btn-cancel"])
    Unselect Frame
    Sleep    5s

create immunizations on opememr portal
    Click Element    //span[@data-bind="text: pname()"]
    Sleep    20s
    Select Frame    //iframe[@name="pat"]
    Sleep    2s
    Wait Until Element Is Visible    //a[@href="immunizations.php"]/i[@class="fa fa-pencil-alt fa-sm"]  ${Wait}
    Double Click Element    //a[@href="immunizations.php"]/i[@class="fa fa-pencil-alt fa-sm"]
    Click Element    //input[@name="cvx_code"]
    Input Text    //input[@name="cvx_code"]    1        ##Parameter
    Unselect Frame
    Sleep    2s
    Select Frame    //iframe[@src="https://dev-dsp-open-emr.azurewebsites.net/interface/patient_file/summary/../encounter/find_code_dynamic.php?codetype=CVX,VALUESET"]
    Click Element    //td[text()="diphtheria, tetanus toxoids and pertussis vaccine"]         ##Parameter
    Click Element    //button[@class="btn btn-secondary btn-sm btn-cancel"]
    Unselect Frame
    Sleep    2s
    Select Frame    //iframe[@name="pat"]
    Sleep    2s
    Click Element     //input[@name="immuniz_amt_adminstrd"]         ##Parameter
    Input Text    //input[@name="immuniz_amt_adminstrd"]    500        ##Parameter
    Click Element    //select[@name="manufacturer"]/option[text()="Abbott Laboratories"]        ##Parameter
    Click Element    //select[@name="immuniz_route"]/option[text()="Per Oris"]        ##Parameter
    Click Element    //select[@name="immuniz_admin_ste"]/option[text()="Left Thigh"]        ##Parameter
    Click Element    //textarea[@name="note"]
    Input Text    //textarea[@name="note"]    Test        ##Parameter
    Sleep    2s
    Click Element    //button[@name="save"]
    Sleep    2s
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