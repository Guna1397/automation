*** Settings ***
Documentation    Suite description  Jira-ID: JAYU-215

###Author: Vishakha Pant###
Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections
Resource  Support_API.robot

Suite Setup         Run Keywords  Remove Output files  Initialize DocSpera Azure Functions Variable
Suite Teardown      Close The Browser


Resource  Variables.robot
Resource  Locators.robot
Resource  CommonKeywords.robot
*** Variables ***
${DOCSPERAAFCnt}  0

*** Test Cases ***
## TC01
Docspera App Service Plan Configuration Validation
    [Tags]  Docspera   JAYU-225  prd
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Service Plan
    Then User has Valid Docspera App Service Plan

## TC02
Docspera Azure Function - MRNSEARCH - Configuration Validation
    [Tags]  Docspera  JAYU-226  prd
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for MRNSEARCH
    Then User has Valid Docspera App Function for MRNSEARCH

### TC03
Docspera Azure Function - VELYS_DELTA_UPDATE - Configuration Validation
    [Tags]  Docspera  JAYU-227
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for VELYS_DELTA_UPDATE
    Then User has Valid Docspera App Function for VELYS_DELTA_UPDATE

## TC04
Docspera Azure Function - ID_UPDATE - Configuration Validation
    [Tags]  Docspera  JAYU-228
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for ID_UPDATE
    Then User has Valid Docspera App Function for ID_UPDATE

## TC05
Docspera Azure Function - S3_UPDATE - Configuration Validation
    [Tags]  Docspera  JAYU-229
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for S3_UPDATE
    Then User has Valid Docspera App Function for S3_UPDATE

## TC06
Docspera Azure Function - FHIRBUNDLE_PROCESSING - Configuration Validation
    [Tags]  Docspera  JAYU-230
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for FHIRBUNDLE_PROCESSING
    Then User has Valid Docspera App Function for FHIRBUNDLE_PROCESSING

## TC07
Docspera Azure Function - FHIRUNBUNDLE_PROCESSING - Configuration Validation
    [Tags]  Docspera  JAYU-231
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for FHIRUNBUNDLE_PROCESSING
    Then User has Valid Docspera App Function for FHIRUNBUNDLE_PROCESSING

## TC08
Docspera Azure Function - ID_GEN - Configuration Validation
    [Tags]  Docspera  JAYU-232
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for ID_GEN
    Then User has Valid Docspera App Function for ID_GEN

## TC09
Docspera Azure Function - FHIR_API - Configuration Validation
    [Tags]  Docspera  JAYU-346
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for FHIR_API
    Then User has Valid Docspera App Function for FHIR_API

## TC10
Docspera Azure Function - ORGANIZATION_API - Configuration Validation
    [Tags]  Docspera  JAYU-738
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for ORGANIZATION_API
    Then User has Valid Docspera App Function for ORGANIZATION_API

## TC11
Docspera Azure Function - PRACTITIONER_API - Configuration Validation
    [Tags]  Docspera  JAYU-739
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera App Function for PRACTITIONER_API
    Then User has Valid Docspera App Function for PRACTITIONER_API

## TC12
Docspera Azure Functions RBAC Validation
    [Tags]  Docspera   JAYU-235
    Given User is logged into Azure & user has required Subscription
    When User Validates Docspera Azure Function Roles
    Then User has a Valid Docspera Azure Function Role Configuration

*** Keywords ***
## First level keyword
## TC01
User Validates Docspera App Service Plan
    Log To The Console  Validating Docspera App Service Plan

User has Valid Docspera App Service Plan
    Validate App_Service_Plan_Configuration Overview
    Validate App_Service_Plan_Apps Settings  ${DocsperAAFAppFunc1Name${DocsperaAFCnt}}
    Validate App_Service_Plan_Apps Settings  ${DocsperAAFAppFunc2Name${DocsperaAFCnt}}
    Validate App_Service_Plan_Apps Settings  ${DocsperAAFAppFunc3Name${DocsperaAFCnt}}
    Validate App_Service_Plan_Apps Settings  ${DocsperAAFAppFunc4Name${DocsperaAFCnt}}
    Validate App_Service_Plan_Apps Settings  ${DocsperAAFAppFunc5Name${DocsperaAFCnt}}
    Validate App_Service_Plan_Apps Settings  ${DocsperAAFAppFunc6Name${DocsperaAFCnt}}
    Validate App_Service_Plan_Apps Settings  ${DocsperAAFAppFunc7Name${DocsperaAFCnt}}
    Sleep  10
    Capture Page Screenshot  App_Service_Plan_Settings.png
    Log To The Console  App_Service_Plan_Settings
    Validate App_Service_Plan_Properties Settings

## TC02
User Validates Docspera App Function for MRNSEARCH
    Log To The Console  Validating Docspera App Function for Docspera-mrnsearch

User has Valid Docspera App Function for MRNSEARCH
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc1Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc1Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc1ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc1Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc1Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc1Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc1AppSetting}  ${DOCSPERAAFAppFunc1FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc1Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc1Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc1Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc1Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc1PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc1Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc1IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc1Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc1HTTPS${DOCSPERAAFCnt}}

## TC03
User Validates Docspera App Function for VELYS_DELTA_UPDATE
    Log To The Console  Validating Docspera App Function for Docspera-velys-delta-update

User has Valid Docspera App Function for VELYS_DELTA_UPDATE
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc2Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc2Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc2ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc2Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc2Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc2Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc2AppSetting}  ${DOCSPERAAFAppFunc2FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc2Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc2Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc2Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc2Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc2PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc2Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc2IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc2Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc2HTTPS${DOCSPERAAFCnt}}

## TC04
User Validates Docspera App Function for ID_UPDATE
    Log To The Console  Docspera App Function for Docspera-id-update

User has Valid Docspera App Function for ID_UPDATE
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc3Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc3Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc3ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc3Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc3Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc3Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc3AppSetting}  ${DOCSPERAAFAppFunc3FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc3Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc3Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc3Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc3Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc3PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc3Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc3IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc3Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc3HTTPS${DOCSPERAAFCnt}}

## TC05
User Validates Docspera App Function for S3_UPDATE
    Log To The Console  Validating Docspera App Function for Docspera-s3-update

User has Valid Docspera App Function for S3_UPDATE
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc4Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc4Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc4ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc4Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc4Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc4Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc4AppSetting}  ${DOCSPERAAFAppFunc4FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc4Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc4Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc4Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc4Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc4PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc4Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc4IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc4Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc4HTTPS${DOCSPERAAFCnt}}

## TC06
User Validates Docspera App Function for FHIRBUNDLE_PROCESSING
    Log To The Console  Docspera App Function for DOCSPERA-FHIRBUNDLE-PROCESSING

User has Valid Docspera App Function for FHIRBUNDLE_PROCESSING
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc5Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc5Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc5ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc6Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc5Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc5Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc5AppSetting}  ${DOCSPERAAFAppFunc5FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc5Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc5Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc5Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc5Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc5PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc5Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc5IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc5Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc5HTTPS${DOCSPERAAFCnt}}

## TC07
User Validates Docspera App Function for FHIRUNBUNDLE_PROCESSING
    Log To The Console  Docspera App Function for DOCSPERA-FHIRUNBUNDLE-PROCESSING

User has Valid Docspera App Function for FHIRUNBUNDLE_PROCESSING
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc6Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc6Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc6ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc7Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc6Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc6Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc6AppSetting}  ${DOCSPERAAFAppFunc6FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc6Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc6Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc6Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc6Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc6PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc6Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc6IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc6Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc6HTTPS${DOCSPERAAFCnt}}

## TC08
User Validates Docspera App Function for ID_GEN
    Log To The Console  Docspera App Function for Docspera-id-gen

User has Valid Docspera App Function for ID_GEN
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc7Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc7Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc7ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc5Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration_ID_GEN  ${DOCSPERAAFAppFunc7Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc7Version${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc7FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc7Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc7Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc7Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc7Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc7PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc7Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc7IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc7Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc7HTTPS${DOCSPERAAFCnt}}

## TC09
User Validates Docspera App Function for FHIR_API
    Log To The Console  Docspera App Function for Docspera-fhir_api

User has Valid Docspera App Function for FHIR_API
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc8Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc8Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc8ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc5Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc8Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc8Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc8AppSetting}  ${DOCSPERAAFAppFunc8FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc8Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc8Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc8Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc8Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc8PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc8Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc8IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc8Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc8HTTPS${DOCSPERAAFCnt}}

## TC10
User Validates Docspera App Function for ORGANIZATION_API
    Log To The Console  Docspera App Function for Docspera-Organization_api

User has Valid Docspera App Function for ORGANIZATION_API
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc9Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc9Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc9ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc5Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc9Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc9Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc9AppSetting}  ${DOCSPERAAFAppFunc9FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc9Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc9Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc9Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc9Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc9PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc9Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc9IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc9Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc9HTTPS${DOCSPERAAFCnt}}

## TC11
User Validates Docspera App Function for PRACTITIONER_API
    Log To The Console  Docspera App Function for Docspera-Practitioner_api

User has Valid Docspera App Function for PRACTITIONER_API
    Validate App_Functions_Overview   ${DOCSPERAAFAppFunc10Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc10Region${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc10ResourceGroup${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc5Type${DOCSPERAAFCnt}}
    Validate App_Functions_Configuration  ${DOCSPERAAFAppFunc10Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc10Version${DOCSPERAAFCnt}}   ${DOCSPERAAFAppFunc10AppSetting}  ${DOCSPERAAFAppFunc10FTPState${DOCSPERAAFCnt}}
    Validate App_Functions_Diagnostic_Setting   ${DOCSPERAAFAppFunc10Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc10Diag_SA${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc10Diag_LA${DOCSPERAAFCnt}}
    Validate App_Functions_Networking  ${DOCSPERAAFAppFunc10Name${DOCSPERAAFCnt}}    ${DOCSPERAAFAppFunc10PE${DOCSPERAAFCnt}}
    Validate App_Functions_Identity   ${DOCSPERAAFAppFunc10Name${DOCSPERAAFCnt}}     ${DOCSPERAAFAppFunc10IdentityStatus${DOCSPERAAFCnt}}
    Validate App_Functions_Custom Domain  ${DOCSPERAAFAppFunc10Name${DOCSPERAAFCnt}}  ${DOCSPERAAFAppFunc10HTTPS${DOCSPERAAFCnt}}


## TC12
User Validates Docspera Azure Function Roles
    User Navigates to Azure AD Group Page

User has a Valid Docspera Azure Function Role Configuration
    FOR   ${i}   IN   @{DOCSPERAAF_ADGroups}
        User Validates Azure AD Group  ${i["group_name"]}  ${i["role"]}
    END
    User Validates AD Group does not exist  NA-DS-SIT-DA-AZF-Owner
    Log To The Console  Azure AD groups for DocSpera Azure functions are validated


## Second level keyword
Validate App_Service_Plan_Configuration Overview
    Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
    Click Element  ${AZSearchBox}
    Input Text  ${AZSearchBox}  ${DOCSPERAAFName${DOCSPERAAFCnt}}
    Sleep  10
    Wait Until Element Is Visible  //*[text ()='${DOCSPERAAFName${DOCSPERAAFCnt}}']  ${Wait}
    Sleep  10
    Click Element  //*[text()='${DOCSPERAAFName${DOCSPERAAFCnt}}']
    Wait Until Element Is Visible  ${SubOverview}  ${Wait}
    Wait Until Element Is Visible  //label[@title="Location"]/../../div/div/div/div[@title="${DOCSPERAAFRegion${DOCSPERAAFCnt}}"]  ${Wait}
    Wait Until Element Is Visible  //label[@title="Resource group"]/../../../../div/div/div/div/div/a[@title="${DOCSPERAAFResourceGroup${DOCSPERAAFCnt}}"]  ${Wait}
    Wait Until Element Is Visible  //label[@title="Operating System"]/../../../..//div[@title="${DOCSPERAAFType${DOCSPERAAFCnt}}"]  ${Wait}
    Wait Until Element Is Visible  //label[@title='App Service Plan']/../../../..//div[contains(@title,'P1v3: ${DOCSPERAAFInstanceCount${DOCSPERAAFCnt}}')]  ${Wait}
    Sleep  10
    Capture Page Screenshot  EventHub_${DOCSPERAAFName${DOCSPERAAFCnt}}_Configuration_Overview.png
    Log To The Console  App_Service_plan_Configuration_Overview

Validate App_Service_Plan_Apps Settings
    [Arguments]  ${FunctionName}
    Wait Until Element Is Visible  link:Apps  ${Wait}
    Click Element  link:Apps
    Wait Until Element Is Visible  //*[text()=' | Apps']  ${Wait}
    sleep  10
    Page Should Contain Element  //div[text()='${FunctionName}'][@class='azc-grid-cellContent']

Validate App_Service_Plan_Properties Settings
    Wait Until Element Is Visible  link:Properties  ${Wait}
    Click Element  link:Properties
    Wait Until Element Is Visible  //*[text()=' | Properties']  ${Wait}
    Sleep  10
    Page Should Contain Element  //*[text()='Pricing Tier']/../following-sibling::div/div[text()='${DOCSPERAAFPricingTier${DOCSPERAAFCnt}}']
    Capture Page Screenshot  App_Service_Plan_${DOCSPERAAFPricingTier${DOCSPERAAFCnt}}_Properties_settings.png


Validate App_Functions_Overview
    [Arguments]  ${function_name}  ${region}  ${resource_group}  ${type}
    Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
    Click Element  ${AZSearchBox}
    Input Text  ${AZSearchBox}  ${function_name}
    Sleep  15
    Wait Until Element Is Visible  //*[text()='${function_name}']/following-sibling::div[text()='Function App']  ${Wait}
    Click Element  //*[text ()='${function_name}']/following-sibling::div[text()='Function App']
    Wait Until Element Is Visible  ${SubOverview}  ${Wait}
    Wait Until Element Is Visible  //label[@title="Location"]/../../div/div/div/div[@title="${region}"]  ${Wait}
    Wait Until Element Is Visible  //label[@title="Resource group"]/../../../../div/div/div/div/div/a[@title="${resource_group}"]  ${Wait}
    Wait Until Element Is Visible  //label[@title="Operating System"]/../../../..//div[@title="${type}"]  ${Wait}
    Sleep  10
    Capture Page Screenshot  App_Function_${function_name}_Overview.png
    Log To The Console  App_Function_${function_name}_Overview

Validate App_Functions_Configuration
    [Arguments]  ${function_name}  ${version}   ${func_AppSetting}  ${ftp_state}
    Wait Until Element Is Visible  link:Configuration  ${Wait}
    Click Element  link:Configuration
    Sleep  10
    select frame  //*[@class='fxs-part-frame']
    Wait Until Element Is Visible  //*[text()='Function runtime settings']   ${Wait}
    Click Element  //*[text()='Function runtime settings']/../../span[contains(@class,'linkContent')]
    Wait Until Element Is Visible  //div[text()='Runtime version']/../../../div//span[text()='${version}']  ${Wait}
    Unselect frame
    Sleep  10
    Capture Page Screenshot  App_Function_${function_name}_Configuration_RuntimeSettings.png
    select frame  //*[@class='fxs-part-frame']
    Wait Until Element Is Visible  //*[text()='General settings']   ${Wait}
    Click Element  //*[text()='General settings']/../../span[contains(@class,'linkContent')]
    Wait Until Element Is Visible  //div[text()='FTP state']/../../../div//span[text()='${ftp_state}']  ${Wait}
    Unselect frame
    Sleep  10
    Capture Page Screenshot  App_Function_${function_name}_Configuration_GeneralSetting.png
    select frame  //*[@class='fxs-part-frame']
    Wait Until Element Is Visible  //*[text()='Application settings']   ${Wait}
    Click Element  //*[text()='Application settings']/../../span[contains(@class,'linkContent')]
    Sleep  10
    Capture Page Screenshot  Configuration_${function_name}_Details.png
    FOR   ${i}   IN   @{func_AppSetting}
        Verfiy application setting name value  ${function_name}  ${i["name"]}  ${i["value"]}
    END
    Unselect frame
    Log To The Console  App_Function_${function_name}_Configuration

Validate App_Functions_Configuration_ID_GEN
    [Arguments]  ${function_name}  ${version}  ${ftp_state}
    Wait Until Element Is Visible  link:Configuration  ${Wait}
    Click Element  link:Configuration
    Sleep  10
    select frame  //*[@class='fxs-part-frame']
    Wait Until Element Is Visible  //*[text()='Function runtime settings']   ${Wait}
    Click Element  //*[text()='Function runtime settings']/../../span[contains(@class,'linkContent')]
    Wait Until Element Is Visible  //div[text()='Runtime version']/../../../div//span[text()='${version}']  ${Wait}
    Unselect frame
    Sleep  10
    Capture Page Screenshot  App_Function_${function_name}_Configuration_RuntimeSettings.png
    select frame  //*[@class='fxs-part-frame']
    Wait Until Element Is Visible  //*[text()='General settings']   ${Wait}
    Click Element  //*[text()='General settings']/../../span[contains(@class,'linkContent')]
    Wait Until Element Is Visible  //div[text()='FTP state']/../../../div//span[text()='${ftp_state}']  ${Wait}
    Unselect frame
    Sleep  10
    Capture Page Screenshot  App_Function_${function_name}_Configuration_GeneralSetting.png
    select frame  //*[@class='fxs-part-frame']
    Wait Until Element Is Visible  //*[text()='Application settings']   ${Wait}
    Sleep 10
    Click Element  //*[text()='Application settings']/../../span[contains(@class,'linkContent')]
    Capture Page Screenshot  Configuration_${function_name}_Details.png
    Unselect frame
    Log To The Console  App_Function_${function_name}_Configuration

Validate App_Functions_Networking
    [Arguments]  ${function_name}   ${private_endpoint}
    Wait Until Element Is Visible  link:Networking  ${Wait}
    Click Element  link:Networking
    Sleep  10
    ${PrivateEndpoint_Value}    Get Element Attribute    //*[text()='Private endpoints']/../../../div//span[text()='On']     innerText
    Should Be Equal    ${PrivateEndpoint_Value}  ${private_endpoint}
    Sleep  10
    Capture Page Screenshot  App_Function_${function_name}_Networking.png
    Log To The Console  App_Function_${function_name}_Networking

User has valid Azure AD groups for Azure Functions
    FOR   ${i}   IN   @{DEVICEAF_ADGroups}
        User Validates Azure AD Group  ${i["group_name"]}  ${i["role"]}  ${DeviceAFResourceGroup${DEVICEAFCnt}}
    END
    User Validates AD Group does not exist  DS-QA-DVC-SVC-Owner
    Log To The Console  Azure AD groups for Azure Functions are validated



Validate App_Functions_Diagnostic_Setting
    [Arguments]  ${function_name}  ${storage_account}  ${log_analytics}
    Wait Until Element Is Visible  link:Diagnostic settings  ${Wait}
    Click Element  link:Diagnostic settings
    Sleep  10
    Capture Page Screenshot  Diagnostic_settings_${function_name}.png
    Wait Until Element Is Visible   //*[text()='${log_analytics}']      ${Wait}
    Wait Until Element Is Visible  //*[text()='Edit setting'][@role='button']  ${Wait}
    Click Element  //*[text()='Edit setting'][@role='button']
    Sleep  10
    Wait Until Element Is Visible  //label[text()='Storage account']/../following::div[@class='azc-formElementSubLabelContainer']//div[@aria-label='Storage account']  ${Wait}
    ${StorageAccount_ActualValue}    Get Element Attribute    //label[text()='Storage account']/../following::div[@class='azc-formElementSubLabelContainer']//div[text()='${storage_account}']     innerText
    Should Be Equal    ${StorageAccount_ActualValue}  ${storage_account}
    Sleep  10
    Capture Page Screenshot  Diagnostic_Edit_settings_${storage_account}.png

Verfiy application setting name value
    [Arguments]  ${function_name}  ${ApplicationSetting_Name}     ${ApplicationSetting_Value}
    Wait Until Element Is Visible  //*[@placeholder='Filter application settings']  ${Wait}
    Sleep  10
    ${isElementExist}    Run Keyword And Return Status    Element Should Be Visible   //*[@placeholder='Filter application settings']/../div//i[@data-icon-name='Clear']
    Run Keyword If    ${isElementExist}    Click Element    //*[@placeholder='Filter application settings']/../div//i[@data-icon-name='Clear']
    Input Text  //*[@placeholder='Filter application settings']  ${ApplicationSetting_Name}  clear=True
    Click Element  (//*[text()='${ApplicationSetting_Name}']/../../following::div/button//i[@data-icon-name='Edit'])[1]
    ${AppNameVal_ActualValue}    Get Element Attribute    //div[text()='Value']/../../../div//div/input[@type='text']     defaultValue
    Should Contain    ${AppNameVal_ActualValue}  ${ApplicationSetting_Value}
    Sleep  10
    Capture Page Screenshot  ${function_name}_${ApplicationSetting_Name}_Details.png
    Click Element  //*[text()='Cancel']

Validate App_Functions_Identity
    [Arguments]  ${function_name}   ${Identity_Status}
    Wait Until Element Is Visible  link:Identity  ${Wait}
    Click Element  link:Identity
    Sleep  10
    Click Element  (//*[text()='System assigned'])[1]
    Wait Until Element Is Visible  (//*[text()='System assigned'])[1]  ${Wait}
    Click Element  (//*[text()='System assigned'])[1]
    ${IdentityStatus_ActualValue}    Get Element Attribute    //label[text()='Status']/../following::div[@class='azc-formElementSubLabelContainer']//li[@aria-checked='true']/span[text()='On']     innerText
    Should Be Equal    ${IdentityStatus_ActualValue}  ${Identity_Status}
    Sleep  10
    Capture Page Screenshot  ${function_name}_Identity_Status_Details.png

Validate App_Functions_Custom Domain
    [Arguments]  ${function_name}   ${Custom_DomainStatus}
    Wait Until Element Is Visible  link:Custom domains  ${Wait}
    Click Element  link:Custom domains
    Sleep  10
    ${Custom_Domain_ActualValue}    Get Element Attribute  //label[text()='HTTPS Only:']/../following::div[@class='azc-formElementSubLabelContainer']//span[text()='${Custom_DomainStatus}']   innerText
    Should Be Equal    ${Custom_Domain_ActualValue}  ${Custom_DomainStatus}
    Sleep  10
    Capture Page Screenshot  ${function_name}_Custom_Domain_Details.png