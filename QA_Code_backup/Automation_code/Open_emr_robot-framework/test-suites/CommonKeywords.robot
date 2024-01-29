*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Library  BuiltIn
Library  Process
Library  OperatingSystem
Library  Collections
Library  DateTime


Resource    Variables.robot
Resource    Locators.robot
*** Variables ***
${DownloadDir}=  ${CURDIR}/downloads_robot/
${EMPTY}
*** Keywords ***
Initialize Browser With Custom Download Directory
    # ${downloadDir}  Join Path  .${/}  downloads_robot
    Create Directory  ${DownloadDir}
    ${chromeOptionsVar}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    ${pref}  Create Dictionary  download.default_directory=${downloadDir}
    Call Method  ${chromeOptionsVar}  add_experimental_option  prefs  ${pref}
    Call Method    ${chromeOptionsVar}    add_argument    --headless
    Create Webdriver  Chrome  chrome_options=${chromeOptionsVar}
    Goto  ${AZURL}

User Launches Azure Portal
    Configure Selenium Speed  0.35 s
    Initialize Browser With Custom Download Directory
    # Open Browser  ${AZURL}  chrome
    # ...         set_preference("browser.download.dir", r"${DownloadDir}"")
    Set Window Size  1500  1100
    Retry Page
    Wait Until Element Is Visible  //*[@id="idSIButton9"]  ${Wait}
    Avoid Common Azure Loading Elements
    #Capture Page Screenshot  Browser.png
    Log To Console  Azure URL is Displayed

User Enters Valid Azure Credentials 
    [Arguments]  ${Uname}  ${Pass}
    Input Text  ${EmailID}  ${Uname}
    sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Username_entered_${time}.png
    Wait Until Element Is Visible  ${ClickNext}  ${Wait}
    Click Element  ${ClickNext}
    Retry Page
    Wait Until Element Is Visible  ${Password}  ${Wait}
    Click Element  ${Password}
    Retry Page
    Input Password  ${Password}  ${Pass}
    sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Password_entered_${time}.png
    Wait Until Element Is Visible  ${SubmitButton}  ${Wait}
    Log To Console  Azure Valid UserName and Password verified Successfully
    Click Element  ${SubmitButton}
    sleep  5
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Azure_Home_Page_${time}.png
    Retry Page

User is logged into Azure & user has required Subscription
    Log To The Console  env: ${env}
    Initialize Subscription Variable
    User Launches Azure Portal
    User Enters Valid Azure Credentials  Uname=${AZUserContributor}  Pass=${AZPassword}
    Check For Custom Subscription Then Set Subscription  ${AZUserContributor}



Login Azure and Validate Subscription
    User Logs into Azure Portal with Contributor Role
    User has correct subscription

User Logs into Azure Portal with Contributor Role
    User Launches Azure Portal
    User Enters Valid Azure Credentials   Uname=${AZUserContributor}  Pass=${AZPassword}
    Check For Custom Subscription Then Set Subscription  ${AZUserContributor}

User Logs into Azure Portal with Owner Role
    User Launches Azure Portal
    User Enters Valid Azure Credentials   Uname=${AZUserOwner}  Pass=${AZPassword}
    Check For Custom Subscription Then Set Subscription  ${AZUserOwner}
##Log to console
Log To The Console
    [Arguments]  ${message}
    log to console  ..
    log to console  ..
    log to console  [LOG] ${message}
    log to console  ..
    log to console  ..
##Setting Selenium Speed
Configure Selenium Speed
    [Arguments]  ${time}
    Set Selenium Speed  ${time}
    Log To The Console  Selenium Speed set to ${time}

Validate AD Group Role
    [Arguments]  ${ADUserLink}  ${ResourceSearch}  ${ResourceLink}  ${ADGroup}  ${Role}  ${RoleSelect}  ${ResourceFile}  
    Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
    Sleep  4 s
    Clear Filter Then Input Text  ${AZSearchBox}  All Resources
    Sleep  4 s
    Wait Until Element Is Visible  ${DropdownAllResources}  ${Wait}
    Sleep  2 s
    Click Element  ${DropdownAllResources}
    Wait Until Element Is Visible  ${AllResourcesSearch}  ${Wait}
    Sleep  4 s
    Clear Filter Then Input Text  ${AllResourcesSearch}  ${ResourceSearch}
    Wait Until Element Is Visible  ${ResourceLink}  ${Wait}
    Click Link  ${ResourceLink}
    Wait Until Element Is Visible  //*[@title="East US"]  ${Wait}
    Wait Until Element Is Visible  ${AccessControlLink}  ${Wait}
    Sleep  2 s
    Capture Page Screenshot  ${ResourceFile}Overview.png
    Click Link  ${AccessControlLink}
    Wait Until Element Is Visible  ${Roles}  ${Wait}
    Click Element  ${Roles}
    Wait Until Element Is Visible  ${RoleSearch}  ${Wait}
    Clear Filter Then Input Text  ${RoleSearch}  ${Role}  
    Wait Until Element Is Visible  ${RoleSelect}  ${Wait}
    Click Element  ${RoleSelect}
    Wait Until Element Is Visible  ${ADGroup}  ${Wait}
    Capture Page Screenshot  ${ResourceFile}-group.png
    Click Link  ${ADGroup}
    Sleep  4
    Wait Until Element Is Visible  ${MembersLink}  ${Wait}
    Click Link  ${MembersLink}  
    Wait Until Element Is Visible  ${ADUserLink}  ${Wait}
    Click Element  ${ADUserLink}
    Sleep  8 s
    Capture Page Screenshot  ${ResourceFile}-user.png

User has Security Administrator Role
    Clear Filter Then Input Text  ${AZSearch}  Azure Active Directory
    Wait Until Element Is Visible  //*[text ()='Azure Active Directory']  ${Wait}
    sleep  3 s
    Click Element  //*[text ()='Azure Active Directory']
    sleep  3 s
    Wait Until Element Is Visible  link:Roles and administrators  ${Wait}
    sleep  5 s
    Click Element  link:Roles and administrators
    Sleep  8 s
    Clear Filter Then Input Text  //*[@placeholder='Search by name or description']  Security administrator
    sleep  1 s
    Wait Until Element Is Visible  //*[text ()='Security administrator']  ${Wait}
    sleep  2 s
    Click Element  //*[text ()='Security administrator']
    sleep  4 s
    Capture Page Screenshot  UserHasSecurityAdminRole.png
    Log To Console  User Security Administrator Role Successfuly Validated

Check For Custom Subscription Then Set Subscription    
    [Arguments]  ${Uname}
    ${customsub}  Run Keyword And Return Status  Variable Should Exist  ${CustomSubscription}
    Run Keyword If  "${customsub}" == "False"
        ...         Set Azure Subscription for user  ${Uname}  ${subscription_name}

    Run Keyword If  "${customsub}" == "True"
        ...         Set Azure Subscription for user  ${Uname}  ${CustomSubscription}


Set Azure Subscription for user
    [Arguments]  ${UserEmail}  ${Sub}
    Log To The Console  ${Sub}
    Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
    Avoid Common Azure Loading Elements
    # Wait Until Element Is Visible  //div[text()="${UserEmail}"]  ${Wait}
    # Click Element  //div[text()="${UserEmail}"]
    # Wait Until Element Is Visible  //button[text()="Switch directory"]  ${Wait}
    # Click Element  //button[text()="Switch directory"]
    # Sleep  2 s
    Wait Until Element Is Visible  //a[@aria-label="Settings"]  ${Wait}
    Click Element  //a[@aria-label="Settings"]
    Avoid Common Azure Loading Elements
    Check Current Subscription  ${Sub}
    Avoid Common Azure Loading Elements
    Wait Until Element Is Visible  link:Microsoft Azure  ${Wait}
    Click Element  link:Microsoft Azure 

Check For Frame Visibility And Select It
    [Arguments]  ${Frame}
    ${FrameIsVisible}  Run Keyword And Return Status  Element Should Be Visible  ${Frame}
    Run Keyword If  ${FrameIsVisible}
        ...         Switch To frame  ${Frame}
Switch To frame
    [Arguments]  ${Frame}
    Avoid Common Azure Loading Elements
    set Global Variable  ${NewFrame}  ${Frame}
    Select Frame  ${NewFrame}

Check For Frame Visibility And Unselect It
    [Arguments]  ${Frame}
    Log To The Console  NewFrame= ${NewFrame}
    ${NewFrameSelected}  Run Keyword And Return Status  Should Not Be Equal  "${NewFrame}"  "newframe"
    Run Keyword If  ${NewFrameSelected}
        ...         Unselect Frame
    Run keyword If  not ${NewFrameSelected}
        ...         set Global Variable  ${NewFrame}  newframe

Switch Off of frame
    Avoid Common Azure Loading Elements
    Unselect Frame

Check For Frame Visibility And Click JSON View
    ${FrameIsVisible}  Run Keyword And Return Status  Element Should Be Visible  id:_react_frame_1
    Run Keyword If  ${FrameIsVisible}
        ...         Select Frame and Click JSON View
    Run Keyword If  not ${FrameIsVisible}
        ...         Click JSON View

Select Frame and Click JSON View
    Select Frame  id:_react_frame_1
    Wait Until Element Is Visible  link:JSON View
    Click Element  link:JSON View
    Unselect Frame

Check Current Subscription
    [Arguments]  ${Sub}
    Log To Console  Checking User Subscription
    Sleep  2 s
    ${NotAllSubs}  Run Keyword And Return Status  Element Should Not Be Visible  //div[text()="All subscriptions"]
    ${RightSub}  Run Keyword And Return Status  Element Should Be Visible  //div[text()="${Sub}"]
    Run Keyword If  ${RightSub}
        ...         Log To Console  current Subscription is correct
    Run Keyword If  not ${NotAllSubs} 
        ...         Run Keywords
        ...         Click Element  //div[@aria-label="Filter by subscriptions"]  
        ...         AND  Toggle All Subs  
        ...         AND  Toggle Required Sub  ${Sub}
    Run Keyword If  ${NotAllSubs} and not ${RightSub} 
        ...         Change Subscription  ${Sub}
Change Subscription
    [Arguments]  ${Sub}
    Wait Until Element Is Visible  //div[@aria-label="Filter by subscriptions"]
    Click Element  //div[@aria-label="Filter by subscriptions"]
    Toggle All Subs
    Sleep  1 s
    Toggle All Subs
    Sleep  1 s
    Toggle Required Sub  ${Sub}
    Sleep  1 s

Toggle Required Sub
    [Arguments]  ${Sub}
    ${SubText}  Run Keyword And Return Status  Element Should Be Visible  //span[text()="${Sub}"]
    ${SubTextAndID}  Run Keyword And Return Status  Element Should Be Visible  //span[text()="${subscription_name} (${SubscriptionID})"]
    Avoid Common Azure Loading Elements
    Run Keyword unless  
        ...      ${SubText}
       # ...       Click Element  //span[text()="${Sub} (${SubscriptionID})"]
        ...       Click Element  //span[text()="${subscription_name} (${SubscriptionID})"]
    # Skip If  ${SubTextAndID}
     Run Keyword unless
        ...       ${SubTextAndID}
        ...       Click Element  //span[text()="${Sub}"]     
    Sleep  1 s
Toggle All Subs
    Wait Until Element Is Visible  //span[text()= "Select all"]
    Click Element  //span[text()= "Select all"]
    Sleep  1 s

Clear Filter Then Input Text
    [Arguments]  ${Filter_Locator}  ${Filter_input}
    ${Speed}  Get Selenium Speed
    Log To Console  [STATUS] Changing Speed to use Filter Search Locator
    Set Selenium Speed  0.33 s
    Wait Until Element Is Visible  ${Filter_Locator}  ${Wait}
    Sleep  1 s 
    Avoid Common Azure Loading Elements
    Click Element  ${Filter_Locator}
#    Input Text  ${Filter_Locator}  ${EMPTY}
#    Sleep  1 s
#    Avoid Common Azure Loading Elements
##    Clear Element Text  ${Filter_Locator}
##    Sleep  1 s
    Avoid Common Azure Loading Elements
    Input Text  ${Filter_Locator}  ${Filter_input}  clear=True
    Avoid Common Azure Loading Elements
    Set Selenium Speed  ${Speed}
    Sleep  3 s
    Log To Console  [STATUS] Restored Previous Speed: ${Speed}

Avoid Common Azure Loading Elements
    Wait Until Element Is Not Visible  class:fxs-progress-dots  60s
    Wait Until Element Is Not Visible  class:fxs-bladecontent-progress fxs-portal-background fxs-progress  60s
    Wait Until Element Is Not Visible  class:fxc-gc-loading-image  60s

Avoid Search Filter Loading Element
    Wait Until Element Is Not Visible  //input[@aria-disabled="true"]  ${Wait}

Set Credentials Configuration For Resource
    [Arguments]  ${credName}
    ${apiJson}  Get file  ${basejsonfilepath}api-credentials.json
    ${AJ}  Evaluate  json.loads('''${apiJson}''')  json

    set Global Variable  ${apicred}  ${AJ['${credName}']}
    set Global Variable  ${grantType}  ${apicred['grant_type']}
    set Global Variable  ${clientID}  ${apicred['client_id']}
    set Global Variable  ${clientSec}  ${apicred['client_secret']}
    set Global Variable  ${Resource}  ${apicred['resource']}
    set Global Variable  ${CustomSubscription}  ${apicred['subscription']}
    

Validate Resource Through CLI Using API  
    [Arguments]  ${ResourceName}  ${json}
    Create File  ..${/}Results${/}api_output.txt
    Append To File  ..${/}Results${/}api_output.txt  Test Data: ${json}${\n}
    Log To The Console  Validating Resource: ${ResourceName}.
    set Global Variable  ${RID}  ${json['resourceId']}
    set Global Variable  ${AV}  ${json['apiVersion']}

    User Recieves Token from API
    User Recieves JSON from API

Validate Resource Through Portal Using API
    [Arguments]  ${ResourceName}  ${json}
    Create File  ..${/}Results${/}api_output.txt
    Append To File  ..${/}Results${/}api_output.txt  Test Data: ${json}${\n}

    Wait Until Element Is Visible  ${AZSearch}  ${Wait}
    Click Element  ${AZSearch}
    sleep  3 s
    Clear Filter Then Input Text  ${AZSearch}  ${ResourceName}
    sleep  2 s
    Click Element  //*[text ()='${ResourceName}']
    Avoid Common Azure Loading Elements
    Check For Frame Visibility And Click JSON View
    Avoid Common Azure Loading Elements
    ${ResourceID}  Get Element Attribute  //input[@aria-label="Resource ID"]  title
    set Global Variable  ${RID}  ${ResourceID}
    Page Should Contain Element  //label[contains(text(), "API version")]//../../div/div/div/div[@role="textbox"]
    Click Element  //label[contains(text(), "API version")]//../../div/div/div/div[@role="textbox"]
    Avoid Common Azure Loading Elements
    Page Should Contain Element   //div[@role="tree"]/div/div/div[@role="treeitem"]
    ${ApiVersion}   Get Text  (//div[@role="treeitem"])[1]
    set Global Variable  ${AV}  ${ApiVersion}
    sleep  1 s
    Click Element  (//div[@role="treeitem"])[1]

    User Recieves Token from API
    User Recieves JSON from API
    

Click JSON View
    Wait Until Element Is Visible  link:JSON View
    Click Element  link:JSON View

User Recieves Token from API
    [Documentation]     Keyword to retreive Token From API endpoint
    create session  mysession  ${AADUrl}
    ${headers}   create dictionary  content-type=application/x-www-form-urlencoded
    ${reqData}  create dictionary   grant_type=${grantType}  client_id=${clientID}  client_secret=${clientSec}   resource=${Resource}
    ${res}=   POST On Session  mysession  /  data=${reqData}   headers=${headers}
    Should Be Equal As Integers     ${res.status_code}  200

    set Global Variable  ${Token}  ${res.json()["access_token"]}
    # Log To The Console  ${Token}

User Recieves JSON from API
    [Documentation]     Keyword to retreive JSON From API endpoint
    create session  jsonsession  ${BaseURL}
    ${JSONheaders}  create dictionary   content-type=application/json  Authorization=Bearer ${token}
    #${JSONheaders}  create dictionary   content-type=application/json  Authorization=Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyIsImtpZCI6Im5PbzNaRHJPRFhFSzFqS1doWHNsSFJfS1hFZyJ9.eyJhdWQiOiJodHRwczovL21hbmFnZW1lbnQuYXp1cmUuY29tIiwiaXNzIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvNjEwM2ExMDUtNDAxMy00ZTE3LTgxMjItOTY2NDM3OTc3YmZkLyIsImlhdCI6MTYxOTExMTU1NCwibmJmIjoxNjE5MTExNTU0LCJleHAiOjE2MTkxNDA2NTQsImFpbyI6IkUyWmdZTkIvdUxzeTJQV242MXY5UFIxbkgvc0VBUUE9IiwiYXBwaWQiOiI1ZDgzNGU1YS1lODNiLTRlYzMtYTA4NC1mY2QyZDRjZDNkNzIiLCJhcHBpZGFjciI6IjEiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC82MTAzYTEwNS00MDEzLTRlMTctODEyMi05NjY0Mzc5NzdiZmQvIiwib2lkIjoiY2FjNTVjMTEtM2E5Yy00ZWIzLWFkYzUtZmFmZjI0MmVlNTAzIiwicmgiOiIwLkFUVUFCYUVEWVJOQUYwNkJJcFprTjVkN19WcE9nMTA3Nk1OT29JVDgwdFROUFhJMUFBQS4iLCJzdWIiOiJjYWM1NWMxMS0zYTljLTRlYjMtYWRjNS1mYWZmMjQyZWU1MDMiLCJ0aWQiOiI2MTAzYTEwNS00MDEzLTRlMTctODEyMi05NjY0Mzc5NzdiZmQiLCJ1dGkiOiItUEVMVWhqZU9reVVYaUhWeVVpWEFBIiwidmVyIjoiMS4wIiwieG1zX3RjZHQiOjE1NTE5ODU1MDN9.kUSHmAkDiIGuQaCmxexpppGmEBgnU5FZKxAeoZKk_wNYrZXo1KQpUxrA8pTXDN9xPYvNU5nsJzcEyRRvCAComV2Iw47Sc7ABKGbHT7a1gSG_WGUZz5Vt1f7mUO2XLGu1B8kKTp0osW6d21LC3YX5i1wAZp5bAWDhHf_lcBkGTXpAAybpdNPrb0ixTAAswe4ZGeSul8pyUDtz725Je39_YlGybCO1YpNGEi5AJbiGgqLqpppkFj0KEZyN0E7KaaT_zzM6vDVpV_G-6rkodftV7sa1w2GbuXJ2CMWN4iMqdXoY3uOikzWXY1j4GDUpqt6opQM4_mvrlOmariqz5Ficzg
    ${res}=  GET On Session  jsonsession  url=/${RID}?api-version=${AV}    headers=${JSONheaders}
    ${urlString}  convert to string  ${BaseURL}${RID}?api-version=${AV}
    # [Return]    ${res.content}
    Should Be Equal As Integers     ${res.status_code}  200
    # Log  ${res}
    Append To File  ..${/}Results${/}api_output.txt  ---JSON URL: ${urlString}${\n}
    set Global Variable  ${ResponseJSON}  ${res.json()}
    ${json} =  evaluate  json.dumps(${ResponseJSON})  json 
    Log To The Console  ${RID}?api-version=${AV}
    # Log To The Console  ${ResponseJSON}
    # Log To The Console  ${json}
    Append To File  ..${/}Results${/}api_output.txt  ---JSON Data: ${json}${\n}

Custom Eqaulity Checker
    [Arguments]  ${arg1}  ${arg2}  ${dataType}
    ${match}  Run Keyword And Return Status  Should Be Equal As Strings   ${arg1}  ${arg2}
    Run Keyword If    ${match}  Set Local Variable  @{item}  ${dataType}  validation - Test Data: "${arg1}" , JSON Data: "${arg2}" matches: PASSED
    Run Keyword If  not ${match}  Set Local Variable  @{item}  ${dataType} validation - Test Data: "${arg1}" , JSON Data: "${arg2}" not matches: FAILED
    # Append To File  ..${/}Results${/}api_output.txt  "${dataType}": "${arg1}"${\n}
    Log To The Console  ${item}
    Append To List  ${CustomEqualityList}  ${item}
    Remove Values From List  ${CustomEqualityList}  Create List

Custom Eqaulity Checker String Contains
    [Arguments]  ${arg1}  ${arg2}  ${dataType}
    ${match}=  String Contains   ${arg1}  ${arg2}
    Run Keyword If    ${match}  Set Local Variable  @{item}  ${dataType}  validation - Test Data: "${arg1}" , JSON Data: "${arg2}" matches: PASSED
    Run Keyword If  not ${match}  Set Local Variable  @{item}  ${dataType} validation - Test Data: "${arg1}" , JSON Data: "${arg2}" not matches: FAILED
    # Append To File  ..${/}Results${/}api_output.txt  "${dataType}": "${arg1}"${\n}
    Log To The Console  ${item}
    Append To List  ${CustomEqualityList}  ${item}
    Remove Values From List  ${CustomEqualityList}  Create List

User Logs into Azure Portal with DVC SVC Reader Role
    Run Keyword  User Launches Azure Portal
    Run Keyword  User Enters Valid Azure Credentials   Uname=${DVCSVCReaderUser}  Pass=${AZPassword}
    Run Keyword  Set Azure Subscription for user  ${DVCSVCReaderUser}

User Logs into Azure Portal with DVC SVC Contributor Role
    Run Keyword  User Launches Azure Portal
    Run Keyword  User Enters Valid Azure Credentials   Uname=${DVCSVCContributorUser}  Pass=${AZPassword}
    Run Keyword  Set Azure Subscription for user  ${DVCSVCContributorUser}


Return To Home Page
    Sleep  3
    Click Element  ${AZHome}
Close The Browser
    Close Browser
    Log To The Console  Browser Successfully Closed

User Navigates to Azure AD Group Page
    Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
    Clear Filter Then Input Text  ${AZSearchBox}  Groups
    Wait Until Element Is Visible  //*[text()="Groups"]  ${Wait}
    Click Element  //*[text()="Groups"]
    Sleep  10
    Capture Page Screenshot  Groups_Page.png

User Validates Azure AD Group
    [Arguments]   ${GrpName}  ${GrpRole}
    #${ResourceGrp}
    select frame  //*[@id="_react_frame_1"]
    Wait Until Element Is Visible  //*[text()="New group"]//following::input[@placeholder="Search"]  ${Wait}
    sleep  2 s
    Click Element  //*[text()="New group"]//following::input[@placeholder="Search"]
    Clear Filter Then Input Text  //*[text()="New group"]//following::input[@placeholder="Search"]  ${GrpName}
    Wait Until Element Is Visible  //*[text()="${GrpName}"]  ${Wait}
    Sleep  1 s
    Click Element  //*[text()="${GrpName}"]
    Unselect frame
    Wait Until Element Is Visible  //h1[text()="${GrpName}"]  ${Wait}
    Capture Page Screenshot  Group-${GrpName}-Overview.png
    Wait Until Element Is Visible  //div[contains(text(),"Azure role assignments")]  ${Wait}
    Click Element  //div[contains(text(),"Azure role assignments")]
    Sleep  10
    #Wait Until Element Is Visible  //div[contains(text(),"Resource Group")]  ${Wait}
#    Page Should Contain Element  link:${GrpRole}
    #Page Should Contain Element  link:${ResourceGrp}
#    Page Should Contain Element  //div[contains(text(),"${GrpName}")]
    Capture page Screenshot  Group-${GrpName}-AD-Role-${GrpRole}.png
    Click Element  link:Groups
    Sleep  10
    select frame  //*[@id="_react_frame_1"]
    Click Element   //*[@aria-label='Clear text']
    Sleep  10
    Unselect frame
    Log To The Console  Validated-AD-Group-${GrpName}

User Validates AD Group does not exist
    [Arguments]  ${GrpName}
    select frame  //*[@id="_react_frame_1"]
    Wait Until Element Is Visible  //*[text()="New group"]//following::input[@placeholder="Search"]  ${Wait}
    Click Element  //*[text()="New group"]//following::input[@placeholder="Search"]
    Input Text  //*[text()="New group"]//following::input[@placeholder="Search"]  ${GrpName}
    Sleep  5 s
    Wait Until Element Is Visible  //label[text()="No results."]  ${Wait}
    Unselect Frame
    Capture Page Screenshot  Group-${GrpName}-Not-Found.png

Retry Page
    ${present}  Run Keyword And Return Status   Element Should not Be Visible   //*[@id="error-page-content-tryagain"]
    Run Keyword If    ${present}  Log Console  ELSE  Click Retry
Click Retry
    Log To Console  ---Clicking Retry----
    Click Element  //*[@id="error-page-content-tryagain"]
Log Console
    Log To Console  ..
User is Logged into Azure Portal
    Run Keyword  Return To Home Page
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  UserIsLoggedIntoAzurePortal_${time}.png

# *** COMMONKEYWORDS VP ***
# *** COMMONKEYWORDS VP ***
# *** COMMONKEYWORDS VP ***
# *** COMMONKEYWORDS VP ***

Scroll Page To Location
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

User has correct subscription
    # Clear Filter Then Input Text  ${AZSearchBox}   Subscriptions
    # Wait Until Element Is Visible  ${DropdownValueSubcription}  ${Wait}
    # Sleep  2
    # Click Element   ${DropdownValueSubcription}
    # Sleep  10
    # Clear Filter Then Input Text  ${SubscriptionFilter}  ${SubscriptionNameValue}
    # Wait Until Element Is Visible  ${SubscriptionName}  ${Wait}
    # Sleep   5
    # ${time}  Get current date
    # ${time}  convert date  ${time}  result_format= %H%M%S
    # Capture Page Screenshot  Subscription_resource_page_displayed_${time}.png
    # Element Text Should Be  ${SubscriptionName}   ${SubscriptionNameValue}
    # Log To Console  User account has correct subscription

Logout from Azure Portal
    Click Element   ${UserIcon}
    Wait Until Element Is Visible  ${SignOutLink}  ${Wait}
    Click Element   ${SignOutLink}
    Wait Until Element Is Visible  ${LogoutPage_Title}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  User_is_logged_out_${time}.png
    Sleep   2
    Log To Console  User logged out from Azure portal

Logout Azure Portal and close Browser
    Click Element   ${UserIcon}
    Sleep  10
    Wait Until Element Is Visible  ${SignOutLink}  ${Wait}
    Click Element   ${SignOutLink}
    Wait Until Element Is Visible  ${LogoutPage_Title}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  User_is_logged_out_${time}.png
    Log To Console  User logged out from Azure portal
    Sleep   2
    Close Browser
    Log To Console  Browser Closed Successfully!

Finish Test and Close Browser
    Close Browser
    Log To Console  Browser Closed Successfully!

# *** COMMONKEYWORDS YD ***
# *** COMMONKEYWORDS YD ***
# *** COMMONKEYWORDS YD ***
# *** COMMONKEYWORDS YD ***
User Validates Role
    [Arguments]  ${Resource}  ${ResourceLoc}  ${AccessLoc}  ${ScreenshotName}
    Log To Console  User Validating Role..

User has Valid Role
    [Arguments]  ${Resource}  ${ResourceLoc}  ${AccessLoc}  ${Role}  ${ScreenshotName}
    Clear Filter Then Input Text  ${AZSearch}  ${Resource}
    sleep  2 s
    Wait Until Element Is Visible  ${ResourceLoc}  ${Wait}
    Sleep  2 s
    Click Element  ${ResourceLoc}
    sleep  4 s
    Capture Page Screenshot  ${ScreenshotName}
    Page Should Contain  ${subscription_name}
    Wait Until Element Is Visible  ${AccessLoc}  ${Wait}
    Click Element  ${AccessLoc}
    Wait Until Element Is Visible  ${ViewMyAccess}  ${Wait}
    sleep  3 s
    Click Element  ${ViewMyAccess}
    Wait Until Element Is Visible  //*[@title='${Role}']  ${Wait}
    sleep  3 s
    Page Should Contain Element  //*[@title='${Role}']
    Capture Page ScreenShot  UserAccess${ScreenshotName}
    Sleep  2 s
    Log To Console  User Role Based Access Verified Successfully

User Does not Have Owner Role
    [Arguments]  ${Resource}
    Clear Filter Then Input Text  ${RoleSearch}  ${OwnerRole}
    sleep  3 s
    Page Should Contain  No role assignments to display.
    Capture Page ScreenShot  UserDoesNotHaveOwnerRole.png
    Log To Console  User Does not Have Owner Role
    Wait Until Element Is Visible  ${Roles}  ${Wait}
    Click Element  ${Roles}
    sleep  3 s
    Capture Page ScreenShot  UserCanNotSelectRoles.png
    Log To Console  User Does not Have Owner Role As User Can not Select Roles

User Does not Have Contributor Role
    Wait Until Element Is Visible  ${Roles}  ${Wait}
    Click Element  ${Roles}
    sleep  3 s
    Log To Console  User Does not Have Contributor Role As User Can Select Roles
    Capture Page ScreenShot  UserCanSelectRoles.png
    Wait Until Element Is Visible  ${ContributorRoleLink}  ${Wait}
    Click Element  ${ContributorRoleLink}
    sleep  3 s
    Capture Page ScreenShot  UserNotListedUnderContributorRole.png
    Log To Console  User Does not Have Contributor Role

Retry Log-in to Azure Portal
    Scroll Element Into View  ${Retry}
    Click Element  ${Retry}

User can Perform Actions on Resource Respective to Role
    [Arguments]  ${Resource}  ${ResourceLoc}  ${MenuOptionSelect}  ${CreateNewLoc}  ${InputNameLoc}  ${CreateNewBtn}  ${ScreenshotName}  ${RoleBasedOutput}
    Clear Filter Then Input Text  ${AZSearch}  ${Resource}
    Sleep  2 s
    Wait Until Element Is Visible  ${ResourceLoc}  ${Wait}
    Click Element  ${ResourceLoc}
    Wait Until Element Is Visible  ${MenuOptionSelect}  ${Wait}
    Scroll Element Into View  ${MenuOptionSelect}
    Click Element  ${MenuOptionSelect}
    sleep  3 s
    Wait Until Element Is Visible  ${CreateNewLoc}  ${Wait}
    Click Element  ${CreateNewLoc}
    Clear Filter Then Input Text  ${InputNameLoc}  ${ContainerName}
    Wait Until Element Is Visible  ${CreateNewBtn}  ${Wait}
    Sleep  3 s
    Click Element  ${CreateNewBtn}
    Sleep  9 s
    Wait Until Element Is Visible  ${Notifications}  ${Wait}
    Click Element  ${Notifications}
    sleep  15 s
    run keyword if   '${RESOURCE}'=='${VNET1}'  Alertbox Click OK
    Page Should Contain  ${RoleBasedOutput}
    Capture Page ScreenShot  ${ScreenshotName}
    # Wait Until Element Is Visible  //button[@aria-label="Close blade 'Notifications'"]  ${Wait}
    # Click Element  //button[@aria-label="Close blade 'Notifications'"]
    Log To Console  User Role Based Actions Verified Successfully
Alertbox Click OK
    Handle Alert 

User has AKS Cluster Contributor Role
    [Arguments]  ${Resource}
    Wait Until Element Is Visible  ${AZSearch}  ${Wait}
    Click Element  ${AZSearch}
    Clear Filter Then Input Text  ${AZSearch}  ${Resource}
    Wait Until Element Is Visible  //*[text () = '${Resource}']  ${Wait}
    Click Element  //*[text () = '${Resource}']
    Wait Until Element Is Visible  link:Identity  ${Wait}
    Click Element  link:Identity
    Page Should Contain Element  //ul[@role="radiogroup" and @aria-disabled="false"]
    Capture Page Screenshot  ${Resource}_AKS_Contributor.png

User has AKS Cluster Reader Role
    [Arguments]  ${Resource}
    Wait Until Element Is Visible  ${AZSearch}  ${Wait}
    Click Element  ${AZSearch}
    Clear Filter Then Input Text  ${AZSearch}  ${Resource}
    Wait Until Element Is Visible  //*[text () = '${Resource}']  ${Wait}
    Click Element  //*[text () = '${Resource}']
    Wait Until Element Is Visible  link:Identity  ${Wait}
    Click Element  link:Identity
    Page Should Contain Element  //ul[@role="radiogroup" and @aria-disabled="true"]
    Capture Page Screenshot  ${Resource}_AKS_Reader.png

User can Perform Actions on MySQL Respective to Role
    [Arguments]  ${ScreenshotName}  ${RoleBasedOutput}
    Clear Filter Then Input Text  ${AZSearch}  ${AZMySQL}
    Wait Until Element Is Visible  ${AZMySQLDropDown}  ${Wait}
    sleep  2 s
    Click Element  ${AZMySQLDropDown}
    Wait Until Element Is Visible  ${NewPasswordBtn}  ${Wait}
    sleep  2 s
    Click Element  ${NewPasswordBtn}
    sleep  4.5 s
    Page Should Contain  ${RoleBasedOutput}
    sleep  2 s
    Capture Page ScreenShot   RoleActions${ScreenshotName}
    Log To Console  User Role Based Actions on MySQL Verified Successfully

User has Contributor Role for the Resource
    [Arguments]  ${FilterElement}  ${SelectNewElement}  ${ScreenshotName}  ${DeleteBtn}  ${DelTxtInput}  ${DelConfirmBtn}
    Clear Filter Then Input Text  ${FilterElement}  ${ContainerName}
    Wait Until Element Is Visible  ${SelectNewElement}  ${Wait}
    Click Element  ${SelectNewElement}
    Capture Page Screenshot  ${ScreenshotName}
    Wait Until Element Is Visible  ${DeleteBtn}  ${Wait}
    Click Element  ${DeleteBtn}
    Sleep  2 s
    Clear Filter Then Input Text  ${DelTxtInput}  ${ContainerName}
    Wait Until Element Is Visible  ${DelConfirmBtn}  ${Wait}
    Click Element  ${DelConfirmBtn}
    Log To Console  User Contributor Role Based Action Verified Successfully
    sleep  3 s

User has AKS Contributor Role
    Wait Until Element Is Visible  ${NewAKSInboundRuleSelect}  ${Wait}
    Open Context Menu  ${NewAKSInboundRuleSelect}
    Capture Page Screenshot  ${NewAKSRuleSelect}
    Wait Until Element Is Visible  ${DeleteBtn}  ${Wait}
    Click Element  ${DeleteBtn}
    Wait Until Element Is Visible  ${DeleteConfirmBtnY}  ${Wait}
    Click Element  ${DeleteConfirmBtnY}
    Log To Console  User AKS Contributor Role Based Action Verified Successfully

User has Contributor Role
    [Arguments]  ${NewElementSelect}  ${Screenshotname}  ${DelConfirmBtn}  ${FilterField}  ${Context}
    Wait Until Element Is Visible  ${Refresh}  ${Wait}
    Click Element  ${Refresh}
    Sleep  3 s
    Clear Filter Then Input Text  ${FilterField}  ${ContainerName}
    Wait Until Element Is Visible  ${Context}  ${Wait}
    Open Context Menu  ${Context}
    sleep  3 s
    Capture Page Screenshot  ${Screenshotname}
    Wait Until Element Is Visible  ${DeleteBtn}  ${Wait}
    Click Element  ${DeleteBtn}
    Wait Until Element Is Visible  ${DelConfirmBtn}  ${Wait}
    Click Element  ${DelConfirmBtn}
    sleep  2 s
    Log To Console  User Contributor Role Based Action Verified Successfully
    Close Browser

User has a Valid Event Hub Configuration
    Wait Until Element Is Visible  ${NetOption}  ${Wait}
    Click Element  ${NetOption}
    sleep  3 s
    Wait Until Element Is Visible  ${PVTEndpointConnectionsLink}  ${Wait}
    Click Element  ${PVTEndpointConnectionsLink}
    Wait Until Element Is Visible  ${PVTEndpointSelect}  ${Wait}
    Click Element  ${PVTEndpointSelect}
    sleep  3 s
    Page Should Contain Element  ${EHVNETSub}
    Log To Console  User Event Hub Configuration Verified Successfully

Captured Evidence is Uploaded to Jira
    [Arguments]  ${JiraID}
    Run Process  python3.7  ../jira.py  ${JiraID}  stdout=./output.txt
    Close Browser


User Navigates to Sub Page
    Clear Filter Then Input Text  ${AZSearch}  Subscriptions
    Wait Until Element Is Visible  ${SubscriptionsDropDown}  ${Wait}
    sleep  2 s
    Click Element  ${SubscriptionsDropDown}
    # Clear Filter Then Input Text  ${FilterSubscriptions}  ${Subscription}
    # Sleep  1 s
    Wait Until Element Is Visible  ${SubLink}  ${Wait}    

User has Access to Required Subscription
    Log To Console  Checking User Subscription
    User Navigates to Sub Page
    Avoid Common Azure Loading Elements
    Click Element  ${SubLink}
    Wait Until Element Is Visible  ${Resources}  ${Wait}
    Click Element  ${Resources}
    Avoid Common Azure Loading Elements
    Sleep  1 s
    Capture Page Screenshot  Required-Subscription.png
    Log To The Console  User Access to Required Subscription Verified Successfully

User has a Valid AKS Cluster Configuration
    [Arguments]  ${ResourceGroup}  ${Resource}  ${AKSID}  ${KubeVersion}  ${Location}  ${NodeSize}
    #${AksPoliciesLoc}=  Set Variable  //*[@href="#@surgicalnet.io/resource/subscriptions/90b05d3b-a60b-49b6-8c3b-324c715accd8/resourceGroups/${ResourceGroup}/providers/Microsoft.ContainerService/managedClusters/${Resource}/policy"]
    ## ${result}=  Run Process  python3.7  ../infra_validation/robot-framework/scripts/namespaces_validation.py  ${AKSID}  stdout=./output.txt  stderr=./run_process_error.txt
    ##Log To Console  ${result.stdout}
    Clear Filter Then Input Text  ${Filter}  ${Resource}
    Sleep  ${Wait}
    Page Should Not Contain  No resources to display
    Wait Until Element Is Visible  link:${Resource}  ${Wait}
    Click Element  link:${Resource}
    Wait Until Element Is Visible  ${SubLink}
    Sleep  ${Wait}
    Page Should Contain  ${ResourceGroup}
    Page Should Contain  ${subscription_name}
    #Page Should Contain  //*[text()='${KubeVersion}]
    Page Should Contain  ${Location}
    Capture Page Screenshot  AKSCluster_OverviewValidation.png
    Scroll Element Into View  ${AKSNodeSizeLoc}
    Page Should Contain  ${NodeSize}
    Capture Page Screenshot  AKSCluster_DetailsValidation.png
    @{ITEMS}=   Create List    Node pools  Configuration    Networking   Deployment center (preview)  Locks
    FOR    ${ELEMENT}    IN    @{ITEMS}
        Log To The Console  ${ELEMENT}
        Wait Until Element Is Visible  link:${ELEMENT}  ${Wait}
        Click Element  link:${ELEMENT}
        Avoid Common Azure Loading Elements
        Sleep  2 s
        Capture Page Screenshot  AKS_${ELEMENT}.png
    END
    Avoid Common Azure Loading Elements
    # Click Element  //h2[text()='${Resource}']//following::button[contains(@aria-label,'Close content')]
    Log To Console  User AKS Cluster Configuration Verified Successfully

User has Valid AKS Cluster Network Configuration
    [Arguments]  ${AKSVMKey}  ${AKSVMName}  ${Subnet}  ${Cidr} 
    Clear Filter Then Input Text  ${Filter}  ${AKSVMKey}
    sleep  3 s
    Page Should Not Contain  No resources to display
    Wait Until Element Is Visible  ${AKSVMName}  ${Wait}
    Click Element  ${AKSVMName}
    sleep  3 s
    Capture Page Screenshot  AKS${Subnet}VMOverview.png
    Wait Until Element Is Visible  link:${VNET2}/${Subnet}  ${Wait}
    Click Element  link:${VNET2}/${Subnet}
    Wait Until Element Is Visible  ${SubnetOption}  ${Wait}
    Click Element  ${SubnetOption}
    Clear Filter Then Input Text  ${SubnetFilter}  ${Subnet}
    sleep  10 s
    Page Should Contain  ${Cidr}
    Capture Page Screenshot  AKS_${AKSVMKey}_Subnet.png
    Log To Console  User AKS Cluster Network Configuration Verified Successfully

Validate AKS Cluster Network Configuration
    [Arguments]  ${AKSVMKey}  @{SUBNET}
    Clear Filter Then Input Text  ${AZSearchBox}  Virtual machine scale sets
    sleep  5 s
    Wait Until Element Is Visible  //*[text ()='Virtual machine scale sets']  ${Wait}
    sleep  5 s
    Click Element  //*[text ()='Virtual machine scale sets']
    sleep  5 s
    Capture Page Screenshot  AKS_${AKSVMKey}_Virtual_machine_scale_sets.png
    Clear Filter Then Input Text  ${FilterName}  ${AKSVMKey}
    sleep  5
    Wait Until Element Is Visible  //a[contains(text(),'${AKSVMKey}')]  20
    Click Element  //a[contains(text(),'${AKSVMKey}')]
    sleep  10 s
    Capture Page Screenshot  AKS_${AKSVMKey}_VMOverview.png
    Wait Until Element Is Visible  //div[text()='Virtual network/subnet']/following::div/following::a[contains(text(),"${VNET2}")]  ${Wait}
    Click Element  //div[text()='Virtual network/subnet']/following::div/following::a[contains(text(),"${VNET2}")]
    Wait Until Element Is Visible  ${SubnetOption}  ${Wait}
    Click Element  ${SubnetOption}
    Clear Filter Then Input Text  ${SubnetFilter}  ${Subnet}
    sleep  10 s
    FOR   ${i}   IN   @{SUBNET}
        Wait Until Element is visible  //a[text()="${i["subnet_name"]}"]
        Wait Until Element is visible  //*[text()="${i["subnet_id"]}"]
    END
    Capture Page Screenshot  AKS_${AKSVMKey}_Subnet.png
    Log To Console  User AKS Cluster Network Configuration Verified Successfully

AKS Assocation with RBAC is Enabled
    [Arguments]  ${Resource}
    Click Element  link:${Resource}
    Wait Until Element Is Visible  ${ConfigurationLoc}  ${Wait}
    Click Element  ${ConfigurationLoc}
    Wait Until Element Is Visible  //div[text()="Upgrade"]  ${Wait}
    sleep  5
    Page Should Contain Element  ${AKSRBACEnabled}
    Capture Page Screenshot  AKSAssociationWithRBAC.png
    Log To Console  User AKS Cluster Association with RBAC Verified Successfully

User Validates AKS Clusters
    Clear Filter Then Input Text  ${AZSearch}  Kubernetes services
    sleep  1 s
    Wait Until Element Is Visible  //*[text ()='Kubernetes services']  ${Wait}
    sleep  1 s
    Click Element  //*[text ()='Kubernetes services']
    sleep  3 s
    Capture Page Screenshot  AKSClustersList.png

AKS Auto-Pod Scaling is Configured
    [Arguments]  ${ResourceGroup}  ${Resource}
    ${OverviewLoc}=  Set Variable  //*[@href="#@surgicalnet.io/resource/subscriptions/d12bc007-2c84-4c58-8afb-99e8e2ef5ffe/resourceGroups/${ResourceGroup}/providers/Microsoft.ContainerService/managedClusters/${Resource}/overview"]
    Wait Until Element Is Visible  ${OverviewLoc}  ${Wait}
    Sleep  1 s
    Click Element  ${OverviewLoc}
    # Wait Until Element Is Visible  ${SubOverview}   ${Wait}
    # Click Element  ${SubOverview}
    Wait Until Element Is Visible  //*[@title='Connect']  ${Wait}
    Wait Until Element Is Visible  ${AKSCapabilitiesLoc}  ${Wait}
    Click Element  ${AKSCapabilitiesLoc}
    Wait Until Element Is Visible  //*[text () = 'Autoscaling']  ${Wait}
    Scroll Element Into View  ${AKSAutoScalingConfigured}
    Page Should Contain Element  ${AKSAutoScalingLoc}
    Page Should Contain Element  ${AKSAutoScalingConfigured}
    Capture Page Screenshot  AKSAutoPodScalingIsEnabled.png
    Click Element  ${SubHeaderLink}
    Log To Console  User AKS Cluster Auto-Pod Scaling is Configuration Verified Successfully

##Login Confirmation
User is on Azure Home Page
    Run Keyword  Return To Home Page
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Azure-Home_page.png

User Validates Service Principal
    [Arguments]  ${Resource}  ${ADGroup} 
    Given User is Logged into Azure Portal
    Clear Filter Then Input Text  ${AZSearch}  ${Resource}
    Click Element  //*[text()="${Resource}"]
    Avoid Common Azure Loading Elements
    # Wait Until Element Is Visible  //*[contains(string(), "Access control (IAM)")]  ${Wait}
    Click Element  //div[contains(text(), "Access control")] 
    Avoid Common Azure Loading Elements
    # Wait Until Element Is Visible  //span[text()="Role assignments"]  ${Wait}
    Click Element  //span[text()="Role assignments"]
    Wait Until Element Is Visible  //input[@aria-label = "Search by name or email"]  ${Wait}
    Clear Filter Then Input Text  //input[@aria-label = "Search by name or email"]  ${ADGroup}
    Click Element  link:${ADGroup}
    Avoid Common Azure Loading Elements
    Capture Page ScreenShot  ServicePrincipal-${ADGroup}-validated.png


##Validating Role Assigned to AZ AD Group
Validate Azure AD Group Role Assignment
    [Arguments]  ${ADGroup}  ${Role}  ${ResourceGroup}
    Wait Until Element Is Visible  ${AZADGroupsFilter}  ${Wait}
    Click Element  ${AZADGroupsFilter}
    Clear Filter Then Input Text  ${AZADGroupsFilter}  ${ADGroup}
    Wait Until Element Is Visible  ${AZADGroupsFilter}  ${Wait}
    Click Element  ${AZADGroupsFilter}
    Wait Until Element Is Visible  //td[@role="gridcell"]/div/div/div/div[text ()="${ADGroup}"]  ${Wait}
    Click Element  //td[@role="gridcell"]/div/div/div/div[text ()="${ADGroup}"]
    Wait Until Element Is Visible  link:Azure role assignments  ${Wait}
    Click Element  link:Azure role assignments
    Wait Until Element Is Visible  //*[text () = 'Resource Group']
    Page Should Contain Element  //*[text () = '${Role}']
    Page Should Contain Element  //*[text () = '${ResourceGroup}']
    Capture Page Screenshot  Azure_AD_Group_${ADGroup}_Has_Valid_Role.png
    Log To The Console  Successfuly Validated Azure AD Group ${Role} Role Assignment

User navigates to Virtual machine scale sets
    Wait Until Element Is Visible  ${AZSearch}  ${Wait}
    sleep  1 s
    Click Element  ${AZSearch}
    sleep  1 s
    Clear Filter Then Input Text  ${AZSearch}  Virtual machine scale sets
    sleep  1 s
    Wait Until Element Is Visible  //*[text ()='Virtual machine scale sets']  ${Wait}
    sleep  1 s
    Click Element  //*[text ()='Virtual machine scale sets']
    sleep  3 s
    Capture Page Screenshot  Virtual_machine_list.png



