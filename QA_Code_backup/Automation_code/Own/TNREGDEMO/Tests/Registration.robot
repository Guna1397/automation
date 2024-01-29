*** Settings ***
Resource    ../Resources/Registration_App.robot
Resource    ../Resources/Common.robot
#Test Setup    Begin Test
#Test Teardown    End Test


#robot -d Results Demo1.robot
*** Variables ***
${BROWSER} =    chrome
#Open Browser`  http://example.com  Chrome
${URL} =    https://tnreginet.gov.in/portal/

*** Test Cases ***
Access the Home page
    [Documentation]     Test1
    [Tags]    smoke
    Common.Begin test
    Registration_App.Goto landingpage

Access E-services Page
    [Documentation]     Test2
    [Tags]    smoke
   # Registration_App.Goto landingpage
    Registration_App.Goto Eservices page

Autofill Eservices Page
     [Documentation]     Test3
     [Tags]    smoke
     Registration_App.Fill Eservices Page
     #common.end test