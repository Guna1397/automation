## Author: Vishakha Pant

*** Settings ***
Documentation     Checks for setup to work correctly. Jira-ID: JAYU-264
Suite Setup       Initialize Docspera Application Gateway Variables
Suite Teardown     Logout Azure Portal and close Browser

Library  SeleniumLibrary
Library  BuiltIn
Library  DateTime

Resource   Variables.robot
Resource   Locators.robot
Resource   CommonKeywords.robot

*** Variable ***
${DOCSPERAAGCnt}     0
${DOCSPERAAGCnt1}     0

*** Test Cases ***
## TC01
Validate configuration for Docspera Application Gateway
    [Documentation]    Test to check that Application Gateway resource has been set up correctly
    [Tags]    Application Gateway  Docspera  JAYU-271
     Given User is logged into Azure & user has required Subscription
     When User is on Application Gateway screen
     Then User has valid Backend Pool for DocSpera
     And User has valid Listener for DocSpera
     And User has valid HTTP Settings for DocSpera
     And User has valid Health Probe for DocSpera
     And User has valid Rules for DocSpera

### TC02
Validate configuration of Organization and Practitioner API for Docspera Application Gateway
    [Documentation]    Test to check that Organization and Practitioner API for Application Gateway resource has been set up correctly
    [Tags]    Application Gateway  Docspera  JAYU-761  prd
     Given User is logged into Azure & user has required Subscription
     When User is on Application Gateway screen
     Then User has valid Backend Pool for DocSpera for Organization & Practitioner API
     And User has valid Listener for DocSpera for Organization & Practitioner API
     And User has valid Health Probe for DocSpera for Organization & Practitioner API
     And User has valid HTTP Settings for DocSpera for Organization & Practitioner API
     And User has valid Rules for DocSpera for Organization & Practitioner API

*** Keywords ***
### First level keywords ###
User is on Application Gateway screen
    Configure Selenium Speed  3 s
    Application Gateway is searched using Search Option
    Application gateway page is displayed

User has valid Backend Pool for DocSpera
    Backend Pools Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_BackendPool}
        Verfiy backend pool resources  ${i["name"]}  ${i["target"]}
    END
    log to the console  Backend pool details validated

User has valid Backend Pool for DocSpera for Organization & Practitioner API
    Backend Pools Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_BackendPool1}
        Verfiy backend pool resources  ${i["name"]}  ${i["target"]}
    END
    log to the console  Backend pool details validated

User has valid Listener for DocSpera
    Listeners Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_Listner}
        Verfiy Listeners resources  ${i["name"]}  ${i["frontendIp"]}  ${i["port"]}  ${i["certificate"]}  ${i["listner_type"]}  ${i["Host"]}
    END
    log to the console  Listner details validated

User has valid Listener for DocSpera for Organization & Practitioner API
    Listeners Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_Listner1}
        Verfiy Listeners resources  ${i["name"]}  ${i["frontendIp"]}  ${i["port"]}  ${i["certificate"]}  ${i["listner_type"]}  ${i["Host"]}
    END
    log to the console  Listner details validated

User has valid HTTP Settings for DocSpera
    HTTP Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_HTTPSettings}
        Verfiy HTTP Settings resources   ${i["name"]}  ${i["backend_protocol"]}  ${i["RequestTimeOut"]}  ${i["CustomProbe"]}
    END
    log to the console  HTTP Settings details validated

User has valid HTTP Settings for DocSpera for Organization & Practitioner API
    HTTP Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_HTTPSettings1}
        Verfiy HTTP Settings resources   ${i["name"]}  ${i["backend_protocol"]}  ${i["RequestTimeOut"]}  ${i["CustomProbe"]}
    END
    log to the console  HTTP Settings details validated

User has valid Health Probe for DocSpera
    Health probes Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_HealthProbe}
        Verfiy Health Probe resources   ${i["name"]}   ${i["protocol"]}     ${i["Pick_hostname_from_backend_HTTP_settings"]}  ${i["Pick_port_from_backend_HTTP_settings"]}  ${i["Path"]}    ${i["interval"]}  ${i["timeout"]}  ${i["threshold"]}   ${i["Use_probe_matching_conditions"]}  ${i["HTTP_Setting"]}
    END
    log to the console  Health Probe details validated

User has valid Health Probe for DocSpera for Organization & Practitioner API
    Health probes Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_HealthProbe1}
        Verfiy Health Probe resources   ${i["name"]}   ${i["protocol"]}     ${i["Pick_hostname_from_backend_HTTP_settings"]}  ${i["Pick_port_from_backend_HTTP_settings"]}  ${i["Path"]}    ${i["interval"]}  ${i["timeout"]}  ${i["threshold"]}   ${i["Use_probe_matching_conditions"]}  ${i["HTTP_Setting"]}
    END
    log to the console  Health Probe details validated

User has valid Rules for DocSpera
    Rules Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_Rules}
        Verfiy Rules resources  ${i["name"]}  ${i["listener"]}  ${i["backendTarget"]}  ${i["HTTPSettings"]}
    END
    log to the console  Rules details validated

User has valid Rules for DocSpera for Organization & Practitioner API
    Rules Settings is validated
    FOR   ${i}   IN   @{DocsperaAG_Rules1}
        Verfiy Rules resources  ${i["name"]}  ${i["listener"]}  ${i["backendTarget"]}  ${i["HTTPSettings"]}
    END
    log to the console  Rules details validated

### Second Level Keywords ###
Application Gateway is searched using Search Option
    Click Element  ${SearchBar}
    Input Text  ${SearchBar}   Application gateways
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Application-Gateway-option-displayed_${time}.png
    Wait Until Element Is Visible  ${DropdownValueApplicationGateways}  ${Wait}

Application gateway page is displayed
    Click Element   //*[text()='Application gateways'][contains(@class,'result-name')]
    Wait Until Element Is Visible  //h2/span[contains(text(),'Application Gateway')]  ${Wait}
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Application-gateways-screen-is-displayed_${time}.png
    Click Element  link:${ApplicationGatewaysNameValue}
    Wait Until Element Is Visible  //label[@title="Location"]/../../div/div/div/div[contains(@title,"${ApplicationGatewaysRegionValue}")]  ${Wait}
    Wait Until Element Is Visible  //label[@title="Resource group"]/../../../../div/div/div/div/div/a[@title="${ApplicationGatewaysRGValue}"]  ${Wait}
    sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Application-gateway_Overview_${time}.png
    Log To Console  List of all Application Gateways is displayed

Application gateway resource is provisioned
    Wait Until Element Is Visible   ${ResourceFilter}  ${Wait}
    Click Element  ${ResourceFilter}
    Input Text  ${ResourceFilter}  ${ApplicationGatewaysNameValue}
    ${temp} =  Get Text    ${ResourceSubscriptionFilter}
    Run Keyword If  '${temp}' == 'All subscription'  Select Required Subscription
    ...  Else  First Select All Subscription & Then Select Required
    Click Element   ${ApplicationGatewaysHeader}
    Wait Until Element Is Visible  ${ApplicationGatewaysName}  ${Wait}
    Element Text Should Be  ${ApplicationGatewaysName}   ${ApplicationGatewaysNameValue}
    Click Element  ${ApplicationGatewaysName}
    sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Application-gateway-resource-is-provisioned_${time}.png
    Wait Until Element Is Visible   ${AGResource_header}   ${wait}
    Log To Console  Application Gateway resource is provisioned

Select Required Subscription
    Click Element  ${ResourceSubscriptionFilter}
    Click Element   ${ResourceSubscription_DropdownFilter}
    Wait Until Element Is Visible   ${ResourceSubscriptio_Dropdown_SelectAll}    ${Wait}
    Click Element   ${ResourceSubscriptio_Dropdown_SelectAll}
    Click Element   ${ResourceSubscriptio_Dropdown_Subscription}

First Select All Subscription & Then Select Required
    Click Element  ${ResourceSubscriptionFilter}
    Click Element  ${ResourceSubscriptionFilter}
    Click Element   ${ResourceSubscription_DropdownFilter}
    Wait Until Element Is Visible   ${ResourceSubscriptio_Dropdown_SelectAll}    ${Wait}
    Click Element   ${ResourceSubscriptio_Dropdown_SelectAll}
    Click Element   ${ResourceSubscriptio_Dropdown_Subscription}

Backend Pools Settings is validated
    Click Element   ${AG_BackendPools_link}
    Sleep  10
    Wait Until Element Is Visible   ${AG_BackendPools_header}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Backend-Pools-Settings-for-Application-gateway-resource_${time}.png

HTTP Settings is validated
    Click Element   ${AG_HTTPSettings_link}
    Sleep  10
    Wait Until Element Is Visible   ${AG_HTTPSettings_header}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  HTTP-Settings-for-Application-gateway-resource_${time}.png

Frontend IP configuration Settings is validated
    Click Element   ${AG_FrontendIPconfigurations_link}
    Sleep  10
    Wait Until Element Is Visible   ${AG_FrontendIPconfigurations_header}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Frontend IP configuration Settings for Application gateway resource_${time}.png

Listeners Settings is validated
    Click Element   ${AG_Listeners_link}
    Sleep  10
    Wait Until Element Is Visible   ${AG_Listeners_header}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Listeners-Settings-for-Application-gateway-resource_${time}.png

Rules Settings is validated
    Click Element   ${AG_Rules_link}
    Sleep  10
    Wait Until Element Is Visible   ${AG_Rules_header}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Rules-Settings-for-Application-gateway-resource_${time}.png

Health probes Settings is validated
    Click Element   ${AG_Healthprobes_link}
    Sleep  10
    Wait Until Element Is Visible   ${AG_Healthprobes_header}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Healthprobes-Settings-for-Application-gateway-resource_${time}.png

Validate Properties Settings
    Click Element   ${AG_Properties_link}
    Sleep  10
    Wait Until Element Is Visible   ${AG_Properties_header}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Properties-Settings-for-Application-gateway-resource_${time}.png
    Log To Console  Validated Properties Settings for Application gateway resource

Validate Locks Settings
    Click Element   ${AG_Locks_link}
    Sleep  15
    Wait Until Element Is Visible   ${AG_Locks_header}  ${Wait}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Locks-Settings-for-Application-gateway-resource_${time}.png
    Log To Console  Validated Locks Settings for Application gateway resource

Verfiy backend pool resources
    [Arguments]  ${AGResource_BackendPool_NameValue}  ${IP_Value}
    Click Element  ${AG_BackendPool_SearchBar}
    Input Text  ${AG_BackendPool_SearchBar}    ${AGResource_BackendPool_NameValue}
    Wait Until Element Is Visible  //*[@aria-rowindex='1']/div/em[text()='${AGResource_BackendPool_NameValue}']  ${Wait}
    Click Element   //*[@aria-rowindex='1']/div/em[text()='${AGResource_BackendPool_NameValue}']
    Wait Until Element Is Visible   ${AG_EditBackendPool_header}  ${Wait}
    Wait Until Element is Visible  //div[text()='${IP_Value}']  ${Wait}
    Capture Page Screenshot  Backend-Pool-IP-${AGResource_BackendPool_NameValue}-is-displayed.png
    Mouse Over   //div[text()='${IP_Value}']
    Sleep  5
    Click Element  ${AG_EditBackendPool}

Verfiy Listeners resources
    [Arguments]  ${AGResource_Listeners_NameValue}  ${AGResource_Listeners_FrontendIPValue}  ${AGResource_Listeners_PortValue}  ${AGResource_Listeners_CertificateValue}  ${AGResource_Listeners_ListnerTypeValue}  ${AGResource_Listeners_HostNameValue}
    Wait Until Element Is Visible   ${AG_Listeners_SearchBar}  ${Wait}
    Click Element  ${AG_Listeners_SearchBar}
    Sleep  15
    Wait Until Element Is Visible   ${AG_Listeners_SearchBar}  ${Wait}
    Input Text  ${AG_Listeners_SearchBar}    ${AGResource_Listeners_NameValue}
    Wait Until Element Is Visible  //*[@aria-colindex='1']/div/div[text()='${AGResource_Listeners_NameValue}']  ${Wait}
    Click Element   //*[@aria-colindex='1']/div/div[text()='${AGResource_Listeners_NameValue}']
    sleep  15
    Wait Until Element Is Visible   //h2[text()='${AGResource_Listeners_NameValue}']  ${Wait}
    Capture Page Screenshot  ListnerDetails_${AGResource_Listeners_NameValue}.png
    ${AGResource_Listener_ActualFrontendIPValue} =    Get Text    ${AGResource_Listener_FrontendIP}
    should be equal as strings   ${AGResource_Listener_ActualFrontendIPValue}    ${AGResource_Listeners_FrontendIPValue}
    ${AGResource_Listener_ActualPortValue} =    Get Text    ${AGResource_Listener_Port}
    #should be equal as strings   ${AGResource_Listener_ActualPortValue}    ${AGResource_Listeners_PortValue}
    ${AGResource_Listener_ActualCertificateValue} =    Get Text    ${AGResource_Listener_Certicate}
    should be equal as strings   ${AGResource_Listener_ActualCertificateValue}    ${AGResource_Listeners_CertificateValue}
    ${AGResource_Listener_TypeRadio} =    Get Element Attribute    //*[text()='${AGResource_Listeners_ListnerTypeValue}']/../input[@value='true']    checked
    #Page Should Contain Element  //div[text()="${AGResource_Listeners_HostNameValue}"]
    Click Element  //h2[text()='${AGResource_Listeners_NameValue}']/following-sibling::div/button[@title='Close']

Verfiy HTTP Settings resources
    [Arguments]  ${AGResource_HTTPSettings_NameValue}  ${AGResource_HTTPSettings_BackendPortValue}  ${AGResource_HTTPSettings_RequestTimeOutValue}  ${AGResource_HTTPSettings_CustomProbeValue}
    Click Element  ${AG_HTTPSettings_SearchBar}
    Input Text  ${AG_HTTPSettings_SearchBar}    ${AGResource_HTTPSettings_NameValue}
    Wait Until Element Is Visible  //*[@aria-colindex='1']/div/em[text()='${AGResource_HTTPSettings_NameValue}']  ${Wait}
    Click Element   //*[@aria-colindex='1']/div/em[text()='${AGResource_HTTPSettings_NameValue}']
    Wait Until Element Is Visible   ${AG_HTTPSettings_header}  ${Wait}
    sleep  10
    Capture Page Screenshot    ${AGResource_HTTPSettings_NameValue}_HTTP_Settings.png
    ${AGResource_HTTPSettings_BackendProtocolRadio} =    Get Element Attribute    ${AGResource_HTTPSettings_BackendProtocol}     checked
    #should be equal as strings    true    ${AGResource_HTTPSettings_BackendProtocolRadio}
    ${AGResource_HTTPSettings_CACertYesRadio} =    Get Element Attribute    ${AGResource_HTTPSettings_CACertYes}     checked
    #should be equal as strings    true    ${AGResource_HTTPSettings_CACertYesRadio}
    ${AGResource_HTTPSettings_CookieBasedAffinity_Radio} =    Get Element Attribute    ${AGResource_HTTPSettings_CookieBasedAffinity}     checked
    #should be equal as strings    true    ${AGResource_HTTPSettings_CookieBasedAffinity_Radio}
    ${AGResource_HTTPSettings_ConnectionDraining_Radio} =    Get Element Attribute    ${AGResource_HTTPSettings_ConnectionDraining}     checked
    #should be equal as strings    true    ${AGResource_HTTPSettings_ConnectionDraining_Radio}
    ${AGResource_HTTPSettings_UseCustomProbe_Radio} =    Get Element Attribute    ${AGResource_HTTPSettings_UseCustomProbe}     checked
    #should be equal as strings    true    ${AGResource_HTTPSettings_UseCustomProbe_Radio}
    ${AGResource_HTTPSettings_ActualCustomProbeValue} =    Get Text    ${AGResource_HTTPSettings_CustomProbe}
    #should be equal as strings   ${AGResource_HTTPSettings_ActualCustomProbeValue}    ${AGResource_HTTPSettings_CustomProbeValue}
    Scroll Element Into View  ${AGResource_HTTPSettings_CustomProbe}
    Capture Page Screenshot  ${AGResource_HTTPSettings_NameValue}_HTTP-Settings-validated.png
    Click Element  ${AG_HTTPSettings_CloseButton}

Verfiy Health Probe resources
    [Arguments]  ${AGResource_HealthProbe_NameValue}    ${AGResource_HealthProbe_ProtocolValue}  ${AGResource_Pick_hostname_from_backendValue}   ${AGResource_Pick_port_from_backendValue}    ${AGResource_PathValue}   ${AGResource_HealthProbe_IntervalValue}  ${AGResource_HealthProbe_TimeoutValue}  ${AGResource_HealthProbe_UnhealthyThresholdValue}  ${AGResource_ProbeMatchingValuue}  ${AGResource_HTTPSettingValue}
    #[Arguments]  ${AGResource_HealthProbe_NameValue}    ${AGResource_HealthProbe_ProtocolValue}  ${AGResource_Pick_hostname_from_backendValue}   ${AGResource_Pick_port_from_backendValue}    ${AGResource_PathValue}   ${AGResource_HealthProbe_IntervalValue}  ${AGResource_HealthProbe_TimeoutValue}  ${AGResource_HealthProbe_UnhealthyThresholdValue}  ${AGResource_ProbeMatchingValuue}  ${AGResource_HTTPSettingValue}
    Wait Until Element Is Visible   ${AG_HealthProbe_SearchBar}  ${Wait}
    Sleep  10
    Click Element  ${AG_HealthProbe_SearchBar}
    Sleep  10
    Wait Until Element Is Visible   ${AG_HealthProbe_SearchBar}  ${Wait}
    Input Text  ${AG_HealthProbe_SearchBar}    ${AGResource_HealthProbe_NameValue}
    Wait Until Element Is Visible  //*[@aria-colindex='1']/div/em[text()='${AGResource_HealthProbe_NameValue}']  ${Wait}
    Click Element   //*[@aria-colindex='1']/div/em[text()='${AGResource_HealthProbe_NameValue}']
    Wait Until Element Is Visible   //h2[text()='${AGResource_HealthProbe_NameValue}']  ${Wait}
    ${AGResource_HealthProbe_Protocol_Radio} =    Get Element Attribute    ${AGResource_HealthProbe_ProtocolHTTPS}     checked
    ${AGResource_HealthProbe_PickHostName_Radio} =    Get Element Attribute    ${AGResource_HTTPSettings_PickHostNameNo}     checked
    #should be equal as strings    true    ${AGResource_HealthProbe_PickHostName_Radio}
    ${AGResource_HealthProbe_PickPort_Radio} =    Get Element Attribute    ${AGResource_HTTPSettings_PickPortYes}     checked
    #should be equal as strings    true    ${AGResource_HealthProbe_PickPort_Radio}
    ${AGResource_HealthProbe_ProbeMatching_Radio} =    Get Element Attribute    ${AGResource_HTTPSettings_ProbeMatchingNo}     checked
    #should be equal as strings    true    ${AGResource_HealthProbe_ProbeMatching_Radio}
    ${AGResource_HealthProbe_ActualHTTPSettingsValue} =    Get Text    ${AGResource_HealthProbe_HTTPSettings}
    #should be equal as strings   ${AGResource_HealthProbe_ActualHTTPSettingsValue}    ${AGResource_HealthProbe_NameValue}
    Capture Page Screenshot  Health-Probe-is-displayed_${AGResource_HealthProbe_NameValue}.png
    Click Element  //h2[text()='${AGResource_HealthProbe_NameValue}']/following-sibling::div/button[@title='Close']

Verfiy Rules resources
    [Arguments]  ${AGResource_Rules_NameValue}    ${AGResource_Rules_ListenerValue}    ${AGResource_Rules_BackentTargetValue}    ${AGResource_Rules_HTTPSettingsValue}
    Click Element  ${AG_Rules_SearchBar}
    Input Text  ${AG_Rules_SearchBar}    ${AGResource_Rules_NameValue}
    Wait Until Element Is Visible  //*[@aria-colindex='1']/div/em[text()='${AGResource_Rules_NameValue}']  ${Wait}
    Sleep  10
    Click Element   //*[@aria-colindex='1']/div/em[text()='${AGResource_Rules_NameValue}']
    Sleep  10
    Wait Until Element Is Visible  //h2[text()='${AGResource_Rules_NameValue}']  ${Wait}
    Click Element    ${AG_Rule_Listener}
    ${AGResource_Rules_ActualListenerValue} =    Get Text    ${AGResource_Rules_Listener}
    should be equal as strings   ${AGResource_Rules_ActualListenerValue}    ${AGResource_Rules_ListenerValue}
    Capture Page Screenshot  ${AGResource_Rules_NameValue}_Rules-validated.png
    Click Element    ${AG_Rule_BackendTargets}
    ${AGResource_Rules_ActualBackendTargetValue} =    Get Text    ${AGResource_Rules_BackendTarget_dropdown}
    should be equal as strings   ${AGResource_Rules_ActualBackendTargetValue}    ${AGResource_Rules_BackentTargetValue}
    ${AGResource_Rules_ActualHTTPSettingsValue} =    Get Text    ${AGResource_Rules_HTTPSettings_dropdown}
    should be equal as strings   ${AGResource_Rules_ActualHTTPSettingsValue}    ${AGResource_Rules_HTTPSettingsValue}
    ${AGResource_Rules_targetTypeRadio} =    Get Element Attribute    ${AGResource_Rules_targetType}     checked
    #should be equal as strings    true    ${AGResource_Rules_targetTypeRadio}
    Capture Page Screenshot  ${AGResource_Rules_NameValue}_Backend_Target.png
    Click Element  //h2[text()='${AGResource_Rules_NameValue}']/following-sibling::div/button[@title='Close']


User has a Valid AppGateway Hostname Configuration
    Log To Console  Validating AppGateway Hostname Configuration
    ${result}=  Run Process  python3.7  ../infra_validation/robot-framework/scripts/appgtwy_output_generation.py  stdout=./appgtwy_py_output.txt  stderr=./err_py.txt
    Log To Console  ${result.stdout}
    Should Contain  ${result.stdout}  App Gtwy Configuration Test Passed