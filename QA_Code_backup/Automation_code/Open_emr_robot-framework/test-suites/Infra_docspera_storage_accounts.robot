*** Settings ***
Documentation    Suite description  Jira-ID: JAYU-216
###Author: Yishak Desta###
Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections

Resource  Variables.robot
Resource  Locators.robot
Resource  CommonKeywords.robot
Resource  Support_API.robot

Suite Setup  Run Keywords  Remove Output files  Initialize Docspera Storage Account Variables  Initialize DocSpera Key Vault Secret Variables    Initialize Docspera Storage Account Groups Variables
Test Teardown   Close The Browser
*** Variables ***
${DAA_SACnt}                0
${VELYSDL_SACnt}            0
${VELYSDSPERADL_SACnt}      0
${DocSperaSAGroupsCnt}      0

*** Test Cases ***
#TC01
Docspera Azure Storage Account Configuration Validation
    [Tags]  DocSpera    JAYU-236
    Given User is logged into Azure & user has required Subscription
	When User Validates DocSpera Azure Storage Account
	Then User has Valid DocSpera Azure Storage Account

#TC02
Velys Storage Account Configuration Validation
    [Tags]  DocSpera    JAYU-241    prd
    Given User is logged into Azure & user has required Subscription
	When User Validates Velys Azure Storage Account
	Then User has Valid Velys Azure Storage Account

#TC03
VelysDocSpera Storage Account Configuration Validation
    [Tags]  DocSpera    JAYU-239    prd
    Given User is logged into Azure & user has required Subscription
	When User Validates VelysDocSpera Azure Storage Account
	Then User has Valid VelysDocSpera Azure Storage Account

#TC04
Azure DocSpera Storage Account RBAC Validation
  [Tags]   DocSpera  JAYU-237
   Given User is logged into Azure & user has required Subscription
   When User Validates DocSpera Storage Account Roles
   Then User Validates Azure AD Group For DocSpera Storage Account

#TC05
SAS Token Configuration Validation for Storage Account
    [Tags]  KeyVaultDocSpera    JAYU-347
    Given User is logged into Azure & user has required Subscription
	When User Validates DocSpera Key Vault Secret Configuration
	Then User has Valid SAS Token for DocSpera SA containers
	When User Validate Velys key Vault Secret Configuration
	Then User has Valid SAS Token for Velys SA containers


*** Keywords ***
User Validates DocSpera Azure Storage Account
    Log To The Console  Validating DocSpera Azure Storage Account

User Validates Velys Azure Storage Account
    Log To The Console  Validating Velys Azure Storage Account

User Validates VelysDocSpera Azure Storage Account
    Log To The Console  Validating VelysDocSpera Azure Storage Account

User has Valid DocSpera Azure Storage Account
    Validate Configuration Overview     ${DAA_SA_Name${DAA_SACnt}}  ${DAA_SARegion${DAA_SACnt}}     ${DAA_SAResourceGroup${DAA_SACnt}}  ${DAA_SAKind${DAA_SACnt}}
    Validate Networking details         ${DAA_SA_Name${DAA_SACnt}}  ${DAA_SANetworkAccess${DAA_SACnt}}  ${DAA_SAPrivateEndpoint${DAA_SACnt}}    ${DAA_SAVNETName${DAA_SACnt}}   ${DAA_SAVNETSubnetName${DAA_SACnt}}     ${DAA_SAVNETAddressRange${DAA_SACnt}}   ${DAA_SAVNETName2${DAA_SACnt}}  ${DAA_SAVNETSubnetDetails2${DAA_SACnt}}
    Validate Blob and File Service      ${DAA_SA_Name${DAA_SACnt}}
    Validate Geo-replication details    ${DAA_SA_Name${DAA_SACnt}}  ${DAA_SAGeoReplication${DAA_SACnt}}
    Validate Secure Transfer Settings   ${DAA_SA_Name${DAA_SACnt}}  ${DAA_SAsecureTransfer${DAA_SACnt}}
    Validate Encryption Settings        ${DAA_SA_Name${DAA_SACnt}}  ${DAA_SAEncryptionType${DAA_SACnt}}
    Validate Soft Delete is enabled     ${DAA_SA_Name${DAA_SACnt}}  ${DAA_SAsoftdelete_blob${DAA_SACnt}}    ${DAA_SAsoftdelete_days${DAA_SACnt}}
    Validate Diagnostic Settings        ${DAA_SA_Name${DAA_SACnt}}
    Validate Access Keys                ${DAA_SA_Name${DAA_SACnt}}

User has Valid Velys Azure Storage Account
    Validate Configuration Overview     ${VELYSDL_SA_Name${VELYSDL_SACnt}}  ${VELYSDL_SARegion${VELYSDL_SACnt}}             ${VELYSDL_SAResourceGroup${VELYSDL_SACnt}}         ${VELYSDL_SAKind${VELYSDL_SACnt}}
    Validate Networking details         ${VELYSDL_SA_Name${VELYSDL_SACnt}}  ${VELYSDL_SANetworkAccess${VELYSDL_SACnt}}      ${VELYSDL_SAPrivateEndpoint${VELYSDL_SACnt}}    ${VELYSDL_SAVNETName${VELYSDL_SACnt}}       ${VELYSDL_SAVNETSubnetName${VELYSDL_SACnt}}     ${VELYSDL_SAVNETAddressRange${VELYSDL_SACnt}}   ${VELYSDL_SAVNETName2${VELYSDL_SACnt}}  ${VELYSDL_SAVNETSubnetDetails2${VELYSDL_SACnt}}
    Validate Blob and File Service      ${VELYSDL_SA_Name${VELYSDL_SACnt}}
    Validate Geo-replication details    ${VELYSDL_SA_Name${VELYSDL_SACnt}}  ${VELYSDL_SAGeoReplication${VELYSDL_SACnt}}
    Validate Secure Transfer Settings   ${VELYSDL_SA_Name${VELYSDL_SACnt}}  ${VELYSDL_SAsecureTransfer${VELYSDL_SACnt}}
    Validate Encryption Settings        ${VELYSDL_SA_Name${VELYSDL_SACnt}}  ${VELYSDL_SAEncryptionType${VELYSDL_SACnt}}
    Validate Soft Delete is enabled     ${VELYSDL_SA_Name${VELYSDL_SACnt}}  ${VELYSDL_SAsoftdelete_blob${VELYSDL_SACnt}}    ${VELYSDL_SAsoftdelete_days${VELYSDL_SACnt}}
    Validate Diagnostic Settings        ${VELYSDL_SA_Name${VELYSDL_SACnt}}
    Validate Access Keys                ${VELYSDL_SA_Name${VELYSDL_SACnt}}

User has Valid VelysDocSpera Azure Storage Account
    Validate Configuration Overview     ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}  ${VELYSDSPERADL_SARegion${VELYSDSPERADL_SACnt}}             ${VELYSDSPERADL_SAResourceGroup${VELYSDSPERADL_SACnt}}         ${VELYSDSPERADL_SAKind${VELYSDSPERADL_SACnt}}
    Validate Networking details         ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}  ${VELYSDSPERADL_SANetworkAccess${VELYSDSPERADL_SACnt}}      ${VELYSDSPERADL_SAPrivateEndpoint${VELYSDSPERADL_SACnt}}    ${VELYSDSPERADL_SAVNETName${VELYSDSPERADL_SACnt}}       ${VELYSDSPERADL_SAVNETSubnetName${VELYSDSPERADL_SACnt}}     ${VELYSDSPERADL_SAVNETAddressRange${VELYSDSPERADL_SACnt}}   ${VELYSDSPERADL_SAVNETName2${VELYSDSPERADL_SACnt}}  ${VELYSDL_SAVNETSubnetDetails2${VELYSDSPERADL_SACnt}}
    Validate Blob and File Service      ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}
    Validate Geo-replication details    ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}  ${VELYSDSPERADL_SAGeoReplication${VELYSDSPERADL_SACnt}}
    Validate Secure Transfer Settings   ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}  ${VELYSDSPERADL_SAsecureTransfer${VELYSDSPERADL_SACnt}}
    Validate Encryption Settings        ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}  ${VELYSDSPERADL_SAEncryptionType${VELYSDSPERADL_SACnt}}
    Validate Soft Delete is enabled     ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}  ${VELYSDSPERADL_SAsoftdelete_blob${VELYSDSPERADL_SACnt}}    ${VELYSDSPERADL_SAsoftdelete_days${VELYSDSPERADL_SACnt}}
    Validate Diagnostic Settings        ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}
    Validate Access Keys                ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}

## Second level keyword
Validate Configuration Overview
    [Arguments]    ${SA_name}  ${region}  ${resource_group}  ${account_kind}
    Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
    Click Element  ${AZSearchBox}
    Input Text  ${AZSearchBox}  ${SA_name}
    Sleep  10
    Wait Until Element Is Visible  //div[text()='${SA_name}']  ${Wait}
    Sleep  10
    Click Element  //div[text()='${SA_name}']
    Sleep  10
    Wait Until Element Is Visible  ${SubOverview}  ${Wait}
    Avoid Common Azure Loading Elements
    select frame  //iframe[@id='_react_frame_1']
    Wait Until Element Is Visible  //div[text()='Location']/../div[contains(text(),"${region}")]  ${Wait}
    Wait Until Element Is Visible  //div[@aria-label="Resource group "]//a[text()="${resource_group}"]  ${Wait}
    Wait Until Element Is Visible  //div[text()="Account kind"]/../div[text()="${account_kind} (general purpose v2)"]  ${Wait}
    unselect frame
    Sleep  10
    Capture Page Screenshot  ${SA_name}_Overview.png


Validate Networking details
    [Arguments]     ${SA_name}  ${Network_Access}   ${Private_endpoint}     ${VnetName}     ${Vnet1_SubnetName}     ${Vnet1_AddressRange}   ${VnetName2}    ${Vnet2_SubnetDetails}
    Wait Until Element Is Visible  link:Networking  ${Wait}
    Click Element  link:Networking
    sleep  10
    Run Keyword If  '${Network_Access}'=='Selected networks'  Selected networks validation  ${Network_Access}   ${VnetName}     ${Vnet1_SubnetName}     ${Vnet1_AddressRange}   ${VnetName2}    ${Vnet2_SubnetDetails}
    ...     ELSE  All networks validation
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_Networking_Configurations_${time}.png
    Scroll Element Into View  //label[text()='Internet routing']
    Wait Until Element Is Visible  //label[text()='Internet routing']/../preceding-sibling::span[contains(@class,'unchecked')]  ${Wait}
    Click Element  //*[text()='Network Routing']
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_Internet_Routing_Checkbox_${time}.png
    Click Element   (//*[text()='Private endpoint connections'])[1]
    sleep  10
    ${PrivateEndpoint_ActualValue}    Get Element Attribute  //span[text()='Private endpoint']/preceding::div[@class='azc-grid-tableHead']/following::div[@class='azc-grid-tableContent']//a[text()='${Private_endpoint}']   innerText
    Should Be Equal    ${PrivateEndpoint_ActualValue}  ${Private_endpoint}
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_Private_Endpoint_${time}.png
    Log To The Console  Storage Account has valid Networking

Selected networks validation
    [Arguments]     ${Network_Access}   ${VnetName}     ${Vnet1_SubnetName}     ${Vnet1_AddressRange}   ${VnetName2}    ${Vnet2_SubnetDetails}
    Page Should Contain Element  //li[@aria-checked="true"]/span[text () = "${Network_Access}"]
#    Wait Until Element Is Visible  (//*[@role='button' and @aria-expanded='false' and @class='azc-grid-hierarchical-icon'])[1]  ${Wait}
#    Click Element  (//*[@role='button' and @aria-expanded='false' and @class='azc-grid-hierarchical-icon'])[1]
    Wait Until Element Is Visible  //*[text()='${VnetName2}']/preceding-sibling::div[@role='button']
    Click Element  //*[text()='${VnetName2}']/preceding-sibling::div[@role='button']
    sleep  10
    Wait Until Element Is Visible  //*[text()='${VnetName}']/preceding-sibling::div[@role='button']  ${Wait}
    Click Element  //*[text()='${VnetName}']/preceding-sibling::div[@role='button']
    Page Should Contain Element  //*[text()='${VnetName}']
    Scroll Element Into View     //*[text()='${Vnet1_SubnetName}']
    Page Should Contain Element  //*[text()='${Vnet1_SubnetName}']/../../../td//div[text()='${Vnet1_AddressRange}']
    ${isElementExist}    Run Keyword And Return Status    Element Should Be Visible   //div[text()='${VnetName2}']
    Run Keyword If    ${isElementExist}    Validate Vnet2   ${VnetName2}  ${Vnet2_SubnetDetails}

Validate Vnet2
    [Arguments]     ${SAVnetName2}      ${SASubnetDetails2}
    Page Should Contain Element  //*[text()="${SAVnetName2}"]
    FOR   ${i}   IN   @{SASubnetDetails2}
        User Vnet2 Subnet Details   ${i["name"]}    ${i["address_range"]}
    END


All networks validation
    Page Should Contain Element  //li[@aria-checked="true"]/span[text()='${Network_Access}']

Validate Blob and File Service
    [Arguments]     ${SA_name}
    Wait Until Element Is Visible  ${ContainerOption}  ${Wait}
    Click Element  ${ContainerOption}
    sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Blob_Service_Validation_${time}.png
    Log To The Console  Storage Account Contains a Blob Service
    Wait Until Element Is Visible  ${FSOption}  ${Wait}
    Click Element  ${FSOption}
    sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  FileService_Validation_${SA_name}_${time}.png
    Log To The Console  Storage Account Contains a File Service

Validate Geo-replication details
    [Arguments]     ${SA_name}  ${Geo_Replication}
    Click Element  link:Geo-replication
    Avoid Common Azure Loading Elements
    Wait Until Element is Visible  ${StorageAccount_GeoReplication}
    Wait Until Element Is Visible  //label[text()="Replication"]/following::div[contains(text(),"${Geo_Replication}")]
    Page Should Contain Element  //label[text()="Replication"]/following::div[contains(text(),"${Geo_Replication}")]
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_GeoReplication_${time}.png
    Log To The Console  DocSpera Storage Account has valid geo replication

Validate Secure Transfer Settings
    [Arguments]     ${SA_name}  ${Secure_Transfer}
    Click Element  link:Configuration
    Avoid Common Azure Loading Elements
    Wait Until Element is Visible  ${StorageAccount_Configuration}
    Wait Until Element is Visible  //*[text()='Secure transfer required']/../../div//ul/li[@aria-checked='true']//span[text()='${Secure_Transfer}']
    Page Should Contain Element   //*[text()='Secure transfer required']/../../div//ul/li[@aria-checked='true']//span[text()='${Secure_Transfer}']
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_SecureTransfer_Settings_${time}.png
    Log To The Console  DocSpera Storage Account has valid secure transfer settings

Validate Encryption Settings
    [Arguments]     ${SA_name}  ${Encryption_Type}
    Click Element  link:Encryption
    Avoid Common Azure Loading Elements
    Wait Until Element is Visible  ${StorageAccount_Encryption}
    Wait Until Element is Visible  //span[text()='${Encryption_Type}']/preceding::input[@value='Microsoft.Keyvault']//parent::li[@aria-checked='true']
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_Encryption_Settings_${time}.png
    Log To The Console  DocSpera Storage Account has a Valid Encryption settings

Validate Soft Delete is enabled
    [Arguments]     ${SA_name}  ${SoftDelete_Blob}  ${SoftDelete_Days}
    Click Element  link:Data protection
    Wait Until Element is Visible  ${StorageAccount_DataProtection}
    Avoid Common Azure Loading Elements
    Wait Until Element is Visible  //*[text()='Enable soft delete for blobs']/../../preceding-sibling::span[contains(@class,"${SoftDelete_Blob}")]
    Textfield Value should be  //label[text()='Keep deleted containers for (in days)']/../following-sibling::div/div/div/div/input  ${SoftDelete_Days}
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_SoftDelete_Settings_${time}.png
    Log To The Console  DocSpera Storage Account has valid soft delete settings

Validate Diagnostic Settings
    [Arguments]     ${SA_name}
    Click Element  link:Diagnostic settings
    sleep  10
    Wait Until Element is Visible  ${StorageAccount_DiagnosticSettings_Preview}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Diagnostic_Settings_Preview_${time}.png
    Log To The Console  DocSpera Storage Account has a Valid Diagnostic settings_preview
    Click Element  link:Diagnostic settings (classic)
    sleep  10
    Wait Until Element is Visible  ${StorageAccount_DiagnosticSettings_Classic}
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Diagnostic_Settings_Classic_Blob_${time}.png
    sleep  10
    Click Element  (//span[text()='File properties'])[1]
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Diagnostic_Settings_Classic_File_${time}.png
    sleep  10
    Click Element  (//span[text()='Table properties'])[1]
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  Diagnostic_Settings_Classic_Table_${time}.png
    sleep  10
    Click Element  (//span[text()='Queue properties'])[1]
    sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_Diagnostic_Settings_Classic_Queue_${time}.png
    Log To The Console  DocSpera Storage Account has a Valid Diagnostic settings logs

Validate Access Keys
    [Arguments]     ${SA_name}
    Wait Until Element is Visible  link: Access keys  ${Wait}
    Click Element  link: Access keys
    Avoid Common Azure Loading Elements
    Sleep  10
    ${time}  Get current date
    ${time}  convert date  ${time}  result_format= %H%M%S
    Capture Page Screenshot  ${SA_name}_Account_Access_Keys_${time}.png
    Log To The Console  DocSpera Storage Account has a Valid Access Keys

User Validates DocSpera Storage Account Roles
    User Navigates to Azure AD Group Page


User Validates Azure AD Group For DocSpera Storage Account
    FOR   ${i}   IN   @{DOCSPERASAGroups_ADGroup}
        User Validates Azure AD Group  ${i["group_name"]}  ${i["role"]}
    END
    User Validates AD Group does not exist  NA-DS-QA-DA-STG-VELYS-DOCSPERA-Owner
    Log To The Console  Azure_AD_groups_for_DocSpera_Storage_Account_are_validated

User Validates DocSpera Key Vault Secret Configuration
    Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
    Click Element  ${AZSearchBox}
    Input Text  ${AZSearchBox}  Storage accounts
    Sleep  10
    Wait Until Element Is Visible  //div[text()='Storage accounts'][contains(@class,'result-name')]  ${Wait}
    Click Element  //div[text()='Storage accounts'][contains(@class,'result-name')]
    Sleep  10
    Input Text  //input[@placeholder='Filter for any field...']  ${DOCSPERASAName0}
    Sleep  10
    Click Element  //a[text()='${DOCSPERASAName0}'][contains(@class,'gcflink-link')]
    Sleep  10
    Wait Until Element Is Visible  ${SubOverview}  ${Wait}
    Click Element  link:Encryption
    Sleep  10
    Avoid Common Azure Loading Elements
    Wait Until Element is Visible  ${StorageAccount_Encryption}
    Capture Page Screenshot  DocSpera_Storage_Account_Encryption_Page.png
    ${CurrentKey_Value}    Get Element Attribute    //*[text()='Current key']/../following-sibling::div//div/input[@title='https://${DOCSPERAKVNAME0}.vault.azure.net//keys/${DOCSPERASAName0}']     title
    Should Contain    ${CurrentKey_Value}  ${DOCSPERAKVNAME0}
    Sleep  10
    Capture Page Screenshot  DocSpera_Storage_Account_Encryption_Settings.png
    Log To The Console  DocSpera Storage Account has a Valid Encryption settings


User Validate Velys key Vault Secret Configuration
    Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
    Click Element  ${AZSearchBox}
    Input Text  ${AZSearchBox}  Storage accounts
    Sleep  10
    Wait Until Element Is Visible  //div[text ()='Storage accounts']  ${Wait}
    Click Element  //div[text()='Storage accounts']
    Sleep  10
    Input Text  //input[@placeholder='Filter for any field...']  ${DOCSPERASAName1}
    Sleep  10
    Click Element  //a[text()='${DOCSPERASAName1}'][contains(@class,'gcflink-link')]
    Sleep  10
    Wait Until Element Is Visible  ${SubOverview}  ${Wait}
    Click Element  link:Encryption
    Sleep  10
    Avoid Common Azure Loading Elements
    Wait Until Element is Visible  ${StorageAccount_Encryption}
    Capture Page Screenshot  DocSpera_Storage_Account_Encryption_Page.png
    ${CurrentKey_Value}    Get Element Attribute    //*[text()='Current key']/../following-sibling::div//div/input[@title='https://${DOCSPERAKVNAME1}.vault.azure.net//keys/${DOCSPERASAName1}']     title
    Should Contain   ${CurrentKey_Value}  ${DOCSPERAKVNAME1}
    Sleep  10
    Capture Page Screenshot  Velys_DocSpera_Storage_Account_Encryption_Settings.png
    Log To The Console  VelysDocSpera Storage Account has a Valid Encryption settings

User has Valid SAS Token for DocSpera SA containers
    ${DOCSPERAKVSECRETSCntTotal}=  Get Length  ${DOCSPERAKVSECRETS0}
    FOR  ${DOCSPERAKVSECRETCnt}  IN RANGE  ${DOCSPERAKVSECRETSCntTotal}
        Log To The Console  ${DOCSPERAKVSECRETS0[${DOCSPERAKVSECRETCnt}]}
        Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
        Click Element  ${AZSearchBox}
        Sleep  10
        Input Text  ${AZSearchBox}  ${DOCSPERAKVNAME0}
        Wait Until Element Is Visible  //*[text ()='${DOCSPERAKVNAME0}']  ${Wait}
        Click Element  //*[text ()='${DOCSPERAKVNAME0}']
        Wait Until Element Is Visible  link:Secrets
        Click Element  link:Secrets
        Set Window Size  2200  1200
        Sleep  10
        Scroll Element into view  link:Load more
        Click Element  link:Load more
        Sleep  10
        Click Element  link:Load more
        Wait Until Element Is Visible  //*[text()='${DOCSPERAKVSECRETS0[${DOCSPERAKVSECRETCnt}]}']  ${Wait}
        Capture Page Screenshot  ${DOCSPERAKVSECRETS0[${DOCSPERAKVSECRETCnt}]}_kv_secret_access.png
        Click Element  //*[text()='${DOCSPERAKVSECRETS0[${DOCSPERAKVSECRETCnt}]}']
        Sleep  10
        Click Element   //*[text()='CURRENT VERSION']/following::tr[1]
        Wait Until Element Is Visible  //*[@title='Show Secret Value']  ${Wait}
        Sleep  10
        Click Element  //*[@title='Show Secret Value']
        Sleep  10
        Capture Page Screenshot  ${DOCSPERAKVSECRETS0[${DOCSPERAKVSECRETCnt}]}_sas_token_duration.png
        Page Should Contain Element   //*[starts-with(@title, '${DOCSPERAKVSECRETEXP0}')]
        Sleep  5
    END

User has Valid SAS Token for Velys SA containers
    ${DOCSPERAKVSECRETSCntTotal}=  Get Length  ${DOCSPERAKVSECRETS1}
    FOR  ${DOCSPERAKVSECRETCnt}  IN RANGE  ${DOCSPERAKVSECRETSCntTotal}
        Log To The Console  ${DOCSPERAKVSECRETS1[${DOCSPERAKVSECRETCnt}]}
        Wait Until Element Is Visible  ${AZSearchBox}  ${Wait}
        Click Element  ${AZSearchBox}
        Sleep  10
        Input Text  ${AZSearchBox}  ${DOCSPERAKVNAME1}
        Wait Until Element Is Visible  //*[text ()='${DOCSPERAKVNAME1}']  ${Wait}
        Click Element  //*[text ()='${DOCSPERAKVNAME1}']
        Wait Until Element Is Visible  link:Secrets
        Click Element  link:Secrets
        Sleep  10
        Capture Page Screenshot  ${DOCSPERAKVSECRETS1[${DOCSPERAKVSECRETCnt}]}_kv_secret_access.png
        Click Element  link:Load more
        Sleep  10
        Click Element  link:Load more
        Wait Until Element Is Visible  //*[text()='${DOCSPERAKVSECRETS1[${DOCSPERAKVSECRETCnt}]}']  ${Wait}
        Click Element  //*[text()='${DOCSPERAKVSECRETS1[${DOCSPERAKVSECRETCnt}]}']
        Sleep   10
        Click Element   //*[text()='CURRENT VERSION']/following::tr[1]
        Wait Until Element Is Visible  //*[@title='Show Secret Value']  ${Wait}
        Sleep  10
        Click Element  //*[@title='Show Secret Value']
        Sleep  10
        Capture Page Screenshot  ${DOCSPERAKVSECRETS1[${DOCSPERAKVSECRETCnt}]}_sas_token_duration.png
        Page Should Contain Element   //*[starts-with(@title, '${DOCSPERAKVSECRETEXP1}')]
        Sleep  2
    END

User Vnet2 Subnet Details
    [Arguments]   ${vnet2_name}  ${vnet2_addressrange}
    Page Should Contain Element   //*[text()='${vnet2_name}']/../../../td//div[text()='${vnet2_addressrange}']
