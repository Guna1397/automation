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
Library     ../scripts/openemr_import.py

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
${lastname}
${dob}
${gender}
${facilityname}
${practitionerfirstname}
${practitionerlastname}
#${practitionerusername}
#${npi}
${pracusername}
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
#    When create facility on opememr portal
#    Then create practitioner on opememr portal
    When create patient on opememr portal
    And create Encounter on opememr portal
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
#     Open Browser  ${openemrurl}  chrome
#     ...         set_preference("browser.download.dir", r"${DownloadDir}"")
    Set Window Size  1600  1200
    Retry Page

Initialize Browser With Custom Download Directory open
    # ${downloadDir}  Join Path  .${/}  downloads_robot
    Create Directory  ${DownloadDir}
    ${chromeOptionsVar}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    ${pref}  Create Dictionary  download.default_directory=${downloadDir}
    Call Method  ${chromeOptionsVar}  add_experimental_option  prefs  ${pref}
    Call Method    ${chromeOptionsVar}    add_argument    headless
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
    Click Element   //input[@name="phone"]
    Input Text    //input[@name="phone"]    ${testData["phone"]}
    Sleep    1s
    Click Element    //input[@name="street"]
    Input Text    //input[@name="street"]    ${testData["street"]}
    Sleep    1s
    Click Element    //input[@name="city"]
    Input Text    //input[@name="city"]    ${testData["city"]}
    Sleep    1s
    Click Element    //input[@name="state"]
    Input Text    //input[@name="state"]    ${testData["state"]}
    Sleep    1s
    Click Element    //input[@name="postal_code"]
    Input Text    //input[@name="postal_code"]    ${testData["zipcode"]}
    Sleep    1s
    Click Element    //input[@class="form-control" and @name="country_code"]
    Input Text    //input[@class="form-control" and @name="country_code"]   ${testData["country"]}
    Sleep    2s
    Click Element    //input[@class="form-control" and @name="email"]
    Input Text    //input[@class="form-control" and @name="email"]    ${testData["email"]}
    Sleep    2s
    Click Element    //input[@class="form-control" and @name="ncolor"]
    Input Text    //input[@class="form-control" and @name="ncolor"]     ${testData["color"]}
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
    Input Text   //input[@name="rumple"]    ${practitionerusername}   50s           ##Parameter
    Wait Until Element Is Visible  //input[@type="password"]
    Click Element  //input[@type="password"]
    Input Text   //input[@type="password"]    ${testData["adduser"]["password"]}     50s                ##Parameter
    Wait Until Element Is Visible  //input[@name="adminPass"]
    Click Element  //input[@name="adminPass"]
    Input Text   //input[@name="adminPass"]    ${testData["adduser"]["yourpass"]}    50s                  ##Parameter
    Wait Until Element Is Visible  //input[@name="fname"]
    Click Element  //input[@name="fname"]
    Input Text   //input[@name="fname"]     ${practitionerfirstname}   50s                 ##Parameter
    Wait Until Element Is Visible  //input[@name="lname"]
    Click Element  //input[@name="lname"]
    Input Text   //input[@name="lname"]     ${practitionerlastname}   50s                  ##Parameter
    Wait Until Element Is Visible  //input[@name="npi"]
    Click Element  //input[@name="npi"]
    Input Text   //input[@name="npi"]     ${npi}   50s
    Wait Until Element Is Visible  //input[@type="checkbox" and @name="authorized"]
    Click Element  //input[@type="checkbox" and @name="authorized"]
    Wait Until Element Is Visible  //input[@name="portal_user"]
    Click Element  //input[@name="portal_user"]
    Wait Until Element Is Visible  //select[@name="facility_id"]
    Click Element  //select[@name="facility_id"]
#    //select[@name="facility_id"]/option[text()="Your Clinic Name Here"]
#    Wait Until Element Is Visible  //*[@id="new_user"]/table/tbody/tr[6]/td[4]/select/option[23]
#    Click Element  //*[@id="new_user"]/table/tbody/tr[6]/td[4]/select/option[23]
    Wait Until Element Is Visible  //select[@name="facility_id"]//option[text()="${facilityname}"]
    Click Element  //select[@name="facility_id"]//option[text()="${facilityname}"]
    Wait Until Element Is Visible  //select[@name="see_auth"]
    Click Element  //select[@name="see_auth"]
    Wait Until Element Is Visible  //*[@id="new_user"]/table/tbody/tr[8]/td[4]/select/option[3]
    Click Element  //*[@id="new_user"]/table/tbody/tr[8]/td[4]/select/option[3]
    Wait Until Element Is Visible  //select[@name="billing_facility_id"]
    Click Element  //select[@name="billing_facility_id"]
    Wait Until Element Is Visible  //select[@name="billing_facility_id"]//option[text()="${facilityname}"]
    Click Element  //select[@name="billing_facility_id"]//option[text()="${facilityname}"]
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
    Sleep    5s
	Log To The Console    Practitioner added successfully
    Unselect Frame

create patient on opememr portal
    ${pracfnamelname}   queryExecuter   ${pracusername}
    set Global Variable    ${pracfnamelname}
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
    Input Text    //input[@name="form_fname"]   ${firstname}       ##Parameter
    Sleep    2s
    Click Element    //input[@name="form_lname"]
    Input Text    //input[@name="form_lname"]   ${lastname}       ##Parameter
    Sleep    2s
    Wait Until Element Is Visible  //input[@title="Date of Birth"]
    Click Element  //input[@title="Date of Birth"]
    Input Text   //input[@title="Date of Birth"]    ${dob}         ##Parameter
    Wait Until Element Is Visible  //select[@name="form_sex"]
    Click Element  //select[@name="form_sex"]
    Wait Until Element Is Visible  //select[@name="form_sex"]/option[text()="${gender}"]        ##Parameter
    Click Element  //select[@name="form_sex"]/option[text()="${gender}"]        ##Parameter
    Sleep   2s
    Click Element     (//button[@class="btn btn-link btn-block text-light text-left"])[1]
    Sleep    1s
    Click Element    (//button[@class="btn btn-link btn-block text-light text-left"])[2]
    Sleep    2s
    Click Element    //select[@name="form_providerID"]//option[text()="${pracfnamelname[0]} ${pracfnamelname[1]}"]         ##Parameter
    Sleep    2s

    Click Element    //select[@class="form-control form-control-sm mw-100 select-dropdown select2-hidden-accessible"]//option[text()="${pracfnamelname[0]} ${pracfnamelname[1]}"]       #careteam
    Click Element    (//input[@class="select2-search__field"]//following::option[text()= "${facilityname}"])[1]        ##Parameter
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
    Log To The Console    Patient added successfully

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
    CLick Element    (//select[@name="provider_id"]/option[text()= "${pracfnamelname[1]} ${pracfnamelname[0]} "])      ##Parameter
    Click Element    (//select[@name="referring_provider_id"]/option[text()= "${testData["addpatient"]["encounterreferringprovider"]}"])      ##Parameter
    Click Element    (//select[@name="facility_id"]/option[text()= "${facilityname}"])      ##Parameter
    Click Element    (//button[@class="btn btn-primary btn-save"])
    Unselect Frame
	Log To The Console    Encounter added successfully

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
    Log To The Console    Condition added successfully
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
    Log To The Console    AllergyIntolerance added successfully
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
    Log To The Console    Medication added successfully
    ## Device
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
    Log To The Console    Device added successfully
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
    Log To The Console    Surgery added successfully
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
	Sleep    10s   
    Click Element    //input[@name="cvx_code"]
    #Input Text    //input[@name="cvx_code"]    1        ##Parameter
    Unselect Frame
    Sleep    20s
    Select Frame    //iframe[@src="https://dev-dsp-open-emr.azurewebsites.net/interface/patient_file/summary/../encounter/find_code_dynamic.php?codetype=CVX,VALUESET"]
#    Click Element    //td[text()="diphtheria, tetanus toxoids and pertussis vaccine"]         ##Parameter
    Click Element    (//tr[@class="odd"]//td)[2]
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
    Log To The Console    Immunizations added successfully
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
