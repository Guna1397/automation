## Author: Vishakha Pant
## Author: Vishakha Pant

*** Settings ***
Resource    Variables.robot

*** Variables ***
########### PAGE LOCATORS ##########


### LOGIN Page ###
${EmailID}                              //*[@type="email"]
${SelectUser}                           //*[@id="tilesHolder"]/div[1]/div/div/div/div[1]/img
${ClickNext}                            //*[@value="Next"]
${Password}                             //*[@type="password"]
${SubmitButton}                         //*[@type="submit"]
${NextButton}                           //*[@id="idSubmit_ProofUp_Redirect"]
${ButtonYes}                            //*[@value="Yes"]


### Azure Home Page ####
${HomePageLogo}                         //*[text()="Microsoft Azure"]
${HomePage}                             //a[@class='fxs-breadcrumb-crumb fxs-portal-text fxs-breadcrumb-crumb-active']
${SearchBar}                            //*[@placeholder="Search resources, services, and docs (G+/)"]
#${DropdownValue}                       //*[text()='${ServiceName}']
#${Header}                              //h2[text()='${ServiceName}']
${DropdownValueSubcription}             //*[text()="Subscriptions"]
#${DropdownValueLAWResourceName}         //*[text()="${LogAnalyticsWorkspaceNameValue}"]
${DropdownValueLogAnalytics}            //*[text()="Log Analytics workspaces"]
${DropdownValueVirtualNetwork}          //*[@id="Microsoft_Azure_Network_VirtualNetwork"]
#${DropdownValueKeyVaults}              //*[text()="Key vaults"]
${DropdownValueApplicationGateways}     //*[text()="Application gateways"]
${DropdownValueAzureActiveDirectory}    //*[text()="Azure Active Directory"]
${DropdownValuePolicy}                  //*[text()="Policy"]
${DropdownValueActivityLog}             //*[@class='fxs-menu-result-text-primary']/div[text()='Activity log']
${DropdownValueMonitor}                 //*[@class='fxs-menu-result-text-primary']/div[text()='Monitor']
${DropdownValueACR}                     //*[@class='fxs-menu-result-text-primary']/div[text()='Container registries']
${DropdownValueLoadBalancers}           //*[@class='fxs-menu-result-text-primary']/div[text()='Load balancers']
${DropdownValueAlerts}                  //*[text()='Alerts']
${DropDownIoTHub}                       //*[text()='Services']/../following-sibling::ul//div[text()='IoT Hub']
${DropdownValueNetworkWatcher}          //*[text()='Network Watcher']
${DropdownValueStorageAccounts}         //*[@class='fxs-menu-result-text-primary']/div[text()='Storage accounts']
${DropdownFirewall}                     //*[@class='fxs-menu-result-text-primary']/div[text()='Firewalls']
${DropdownValueWAF}                     //*[@class='fxs-menu-result-text-primary']/div[text()='Web Application Firewall policies (WAF)']
${DropdownValueKeyVaults}               //*[@class='fxs-menu-result-text-primary']/div[text()='Key vaults']

## Common Locators ##
${ResourceFilter}                       //input[contains(@placeholder,"Filter")]
${ResourceSubscriptionFilter}           //div[@aria-label="Filter by subscriptions" and text()]
${AZADGroupsFilter}                     //input[@placeholder="Search groups"]

### Subscription Page ###
${Subscription_Header}                  //h2[text()='Subscriptions']
#${SubscriptionName}                     Link: ${SubscriptionNameValue}
${SubscriptionFilter}                   //input[@placeholder="Search"]

### Log Analytics Page ###
${LogAnalyticsHeader}                   //h2[text()='Log Analytics workspaces']
${LAW_Logs}                             //*[text()='Logs']
${LAW_LogsHeader}                       //*[text()=' | Logs']
${LAW_LogsGetStarted}                   //*[text()='Get Started']
${LAW_Close}                            //*[text()='Documentation']/following::button[@aria-label='Close']
${FrameIn}                              //*[@class='fxs-part-frame']
${LAW_QueryBar}                         //*[@class="view-line"]
${LAW_RunQuery}                         //button[@title='Run query (Shift+Enter)']

${AccessControl_AddRoleAssignment}      //*[text()='Add role assignments']
${AccessControl_SelectRole}             //div[text()='Select a role']
${Role_Contributor}                     //*[text()='Contributor']
${Role_AssignAccess}                    //label[text()='Assign access to']/following::div[text()='User, group, or service principal']
${Role_AssignAccessScroll}              //div[@role='treeitem']/span[text()='Virtual Machine Scale Set']
${Role_AssignAccessValue}               //span[text()='Virtual Machine']
${Role_VirtualMachine}                  //*[text()='BindDNS']

## Key Vaults Page ###
${KeyVaultsHeader}                      //h2[text()='Key vaults']
${KeyVaults_Monitor}                    //*[text()='Insights']
${KeyVault_SearchFilter}                //*[@placeholder='Filter for any field...']
${KeyVault_Secret}                      //*[text()='Secrets']
${KeyVault_LoadMore}                    //*[text()='Load more']
${KeyVault_Close}                       //span[text()=' | Secrets']/../following-sibling::div/button[@title='Close']
${Keyvault_DiskEncryption}              //*[text()='Azure Disk Encryption for volume encryption']/../preceding-sibling::span[@class='azc-fill-text azc-validation-border azc-checkBox-determinate azc-checkBox-checked']
${KeyVault_deleteSecret}                //*[text()='Delete']
${KeyVault_Yes}                         //*[text()='Yes']
${Keyvault_refresh_secret}              //*[text()='Generate/Import']//following::div[text()='Refresh']
${ManageDeleteedSecret}                 //*[text()='Manage deleted secrets']
${KeyVault_refresh}                     //*[@id='refresh-button']
${Keyvault_recover}                     //*[text()="Recover"]
${Keyvault_refresh_secret}              //*[text()='Generate/Import']//following::div[text()='Refresh']

## Application gateways Page ###
${ApplicationGatewaysHeader}            //h2[text()='Application gateways']
${ResourceSubscriptio_Dropdown_SelectAll}   //*[@aria-label='Filter by subscriptions']/following-sibling::div/div/div[@aria-label='Select all']//div

${AG_Configuration_link}                //*[text()='Configuration']
${AG_Configuration_header}              //span[contains(text(),'Configuration')]
${AGResource_Configuration_Tier}        //*[text()='Tier']/../following-sibling::div/div//div[@role='textbox']
${AG_WebApplicationFirewall_link}       //*[text()='Web application firewall']
${AG_WebApplicationFirewall_header}     //span[contains(text(),'Web application firewall')]
${AG_BackendPools_link}                 //*[text()='Backend pools']
${AG_BackendPools_header}               //span[contains(text(),'Backend pools')]
${AG_HTTPSettings_link}                 //*[text()='HTTP settings']
${AG_HTTPSettings_header}               //span[contains(text(),'HTTP settings')]
${AG_FrontendIPconfigurations_link}    //*[text()='Frontend IP configurations']
${AG_FrontendIPconfigurations_header}    //span[contains(text(),'Frontend IP configurations')]
${AG_Listeners_link}                    //*[text()='Listeners']
${AG_Listeners_header}                  //span[contains(text(),'Listeners')]
${AG_Rules_link}                        //*[text()='Rules']
${AG_Rules_header}                      //span[contains(text(),'Rules')]
${AG_Rewrites_link}                     //*[text()='Rewrites']
${AG_Rewrites_header}                   //span[contains(text(),'Rewrites')]
${AG_Healthprobes_link}                 //*[text()='Health probes']
${AG_Healthprobes_header}               //span[contains(text(),'Health probes')]
${AG_Properties_link}                   //*[text()='Properties']
${AG_Properties_header}                 //span[contains(text(),'Properties')]
${AG_Locks_link}                        //*[text()='Locks']
${AG_Locks_header}                      //span[contains(text(),'Locks')]

${AG_BackendPool_SearchBar}             //*[@placeholder='Search backend pools']
${AG_BackendPool_Name}                  //*[@aria-rowindex='1']/div/em[text()='test-afl']
${AG_EditBackendPool_header}            //h2[text()='Edit backend pool']
${AGResource_BackendPool_IP}            //div[text()='Target']/following::div[@id='fxc-gc-cell-content_7_3']/div
${AG_EditBackendPool}                   //h2[text()='Edit backend pool']/following-sibling::div/button[@title='Close']
${AG_Listeners_SearchBar}               //*[@placeholder='Search listeners']
${AG_Listeners_Name}                    //*[@aria-colindex='1']/div/em[text()='apd-afl']
${AG_Listeners_header}                  //h2[text()='apd-afl']
${AGResource_Listener_FrontendIP}       //*[text()='Frontend IP']/../following-sibling::div//div[@role='combobox']
${AGResource_Listener_Port}             //label[text()='Port']/../following-sibling::div/div[@class='azc-formElementContainer']//input
${AGResource_Listener_Certicate}        //*[text()='Certificate']/../following-sibling::div//div[@class='azc-formControl azc-input fxc-dropdown-open msportalfx-tooltip-overflow azc-validation-border fxc-dropdown-input']
${AGResource_Listener_Type}             //*[text()='Multi site']/../input[@value='true']
${AGResource_Listener_Host}             //label[text()='Host name']/../following-sibling::div/div[@class='azc-formElementContainer']//input
${AG_Rules_SearchBar}                   //*[@placeholder='Search rules']
${AG_Rules_header}                      //h2[text()='apd-afl']
${AG_Rules_Name}                        //*[@aria-colindex='1']/div/em[text()='apd-afl']
${AG_Rule_Listener}                     (//*[text()='Rule name']/../following::span[text()='Listener'])[1]
${AG_Rule_BackendTargets}               (//*[text()='Rule name']/../following::span[text()='Backend targets'])[1]
${AGResource_Rules_Listener}            //label[text()='Listener']/../following-sibling::div//div[@role='combobox']
${AGResource_Rules_BackendTarget_dropdown}    (//label[text()='Backend target']/../following-sibling::div//div[@role='combobox'])[1]
${AGResource_Rules_HTTPSettings_dropdown}    (//label[text()='HTTP settings']/../following-sibling::div//div[@role='combobox'])[1]
${AGResource_Rules_targetType}                  //li[@aria-checked="true"]/span[text()='Backend pool']
${AG_HTTPSettings_SearchBar}                    //*[@placeholder='Search HTTP settings']
${AG_HTTPSettings_Name}                         //*[@aria-colindex='1']/div/em[text()='apd-afl']
${AG_HTTPSettings_header}                       //*[text()='Add HTTP setting']
${AGResource_HTTPSettings_BackendProtocol}      //li[@aria-checked="true"]/span[text()='HTTPS']
${AGResource_HTTPSettings_BackendPort}          //label[text()='Backend port']/../following-sibling::div/div[@class='azc-formElementContainer']//input
${AGResource_HTTPSettings_CACertYes}            //li[@aria-checked="true"]/span[text()='Yes']
${AGResource_HTTPSettings_CookieBasedAffinity}      //li[@aria-checked="true"]/span[text()='Disable']
${AGResource_HTTPSettings_ConnectionDraining}       //li[@aria-checked="true"]/span[text()='Disable']
${AGResource_HTTPSettings_UseCustomProbe}           //li[@aria-checked="true"]/span[text()='Yes']
${AGResource_HTTPSettings_RequestTimeOut}           //label[text()='Request time-out (seconds)']/../following-sibling::div/div[@class='azc-formElementContainer']//input
${AGResource_HTTPSettings_CustomProbe}              //*[text()='Custom probe']/../following-sibling::div//div[@role='combobox']

${AG_HealthProbe_SearchBar}                         //*[@placeholder='Search probes']
${AG_HealthProbe_Name}                              //*[@aria-colindex='1']/div/em[text()='apd-afl']
${AG_HealthProbe_header}                            //h2[text()='apd-afl']
${AGResource_HealthProbe_ProtocolHTTPS}             //*[text()='Protocol']/../following-sibling::div//ul//*[text()='HTTPS']/../input[@value='true']
${AGResource_HTTPSettings_PickHostNameNo}           //*[text()='Pick host name from backend HTTP settings']/../following-sibling::div//ul//*[text()='No']/../input[@value='false']
${AGResource_HTTPSettings_PickPortYes}              //*[text()='Pick port from backend HTTP settings']/../following-sibling::div//ul//*[text()='Yes']/../input[@value='true']
${AGResource_HTTPSettings_ProbeMatchingNo}          //*[text()='Use probe matching conditions']/../following-sibling::div//ul//*[text()='No']/../input[@value='false']
${AGResource_HealthProbe_Host}                      //label[text()='Host']/../following-sibling::div/div[@class='azc-formElementContainer']//input
${AGResource_HealthProbe_Interval}                  //label[text()='Interval (seconds)']/../following-sibling::div/div[@class='azc-formElementContainer']//input
${AGResource_HealthProbe_Timeout}                   //label[text()='Timeout (seconds)']/../following-sibling::div/div[@class='azc-formElementContainer']//input
${AGResource_HealthProbe_UnhealthyThreshold}        //label[text()='Unhealthy threshold']/../following-sibling::div/div[@class='azc-formElementContainer']//input
${AGResource_HealthProbe_HTTPSettings}              //label[text()='HTTP settings']/../following-sibling::div//div[@role='combobox']
${AG_HealthProbe_CloseButton}                       //h2[text()='apd-afl']/following-sibling::div/button[@title='Close']
${AG_HTTPSettings_CloseButton}                      //h2[text()='Add HTTP setting']/following-sibling::div/button[@title='Close']

### Overview Page ###
${Overview_link}                                    //div[text()="Overview"]

### Access Control (IAM) Page ###
${AccessControl_link}                               //div[text()="Access control (IAM)"]
${CheckAccessButton}                                //span[text()="View my access"]

### Certificates Page ###
${Certificates_link}                                //div[text()="Certificates"]
${Certificates_header}                              //span[text()=" | Certificates"]
${Certificate_status}                               //div[text()='Completed']/following::tr[@role='row']//span[contains(@class,'text')]
${Certificates_CertID}                              //div[text()='Completed']/following::tr[@role='row']//span[contains(@class,'icon')]
${Certificate_CURRENTVERSION}                       //div[text()='CURRENT VERSION']
${Certificates_CurrentVersionID}                    //div[text()='CURRENT VERSION']/following::tr[@role='row']//span[contains(@class,'icon')]
${Certificate_ActivationDate}                       //div[text()='CURRENT VERSION']/following::tr[@role='row']//span[contains(@class,'icon')]/following::td[@aria-colindex='4']
${Certificate_ExpiryDate}                           //div[text()='CURRENT VERSION']/following::tr[@role='row']//span[contains(@class,'icon')]/following::td[@aria-colindex='5']
${Certificate_CertVersion}                          //*[text()='Certificate Version']
${Certificate_Close}                                //*[text()='Certificate Version']/../preceding-sibling::div//button[@title='Close']
${Certificate_IssuancePolicyTab}                    //*[text()="Issuance Policy"]
${Certificate_IssuancePolicy_DNSName}               //*[text()="DNS Names"]
${Certificate_DomainName}                           //*[text()="DNS Name"]/following::*[text()="surgicalnet.io"]

##User Management via Active Directory
${AzureActiveDirectoryHeader}                       //h2[text()='Digital Surgery JNJ']/following::div[text()='Azure Active Directory']
${AzureActiveDirectory_UserTab}                     //*[text()='Manage']/following::div[text()='Users']
${AzureActiveDirectory_UserHeader}                  //*[text()=' | All users (Preview)']
${AD_User_SearchFilter}                             //input[@placeholder='Search users']
${AD_User_SearchFilterResult}                       //div[@class='azc-grid-tableContent']

${AD_User_Profile}                                  //div[text()='Profile']
${AD_User_ProfileHeader}                            //span[text()=' | Profile']
${AD_User_Profile_FName}                            //*[text()='First name']/following::div[1]
${AD_User_Profile_LName}                            //*[text()='Last name']/following::div[1]
${AD_User_Profile_PrincipalName}                    //*[text()='User Principal Name']/following::div[1]
${AD_User_Profile_UserType}                         //*[text()='User type']/following::div[1]


${AD_User_AssignedRoles}                            //div[text()='Assigned roles']
${AD_User_AssignedRolesHeader}                      //span[text()=' | Assigned roles']

${AD_User_AdministrativeUnits}                      //div[text()='Assigned roles']/following::div[text()='Administrative units']
${AD_User_AdministrativeUnitsHeader}                //span[text()=' | Administrative units']

${AD_User_Groups}   //div[text()='Assigned roles']/following::div[text()='Groups']
${AD_User_GroupsHeader}   //span[text()=' | Groups']

${AD_User_Applications}  //div[text()='Applications']
${AD_User_ApplicationsHeader}  //span[text()=' | Applications']

${AD_User_Licenses}  //div[text()='Assigned roles']/following::div[text()='Licenses']
${AD_User_LicensesHeader}  //span[text()=' | Licenses']

${AD_User_Devices}  //div[text()='Assigned roles']/following::div[text()='Devices']
${AD_User_DevicesHeader}  //span[text()=' | Devices']

${AD_User_AzureRoleAssignments}  //div[text()='Assigned roles']/following::div[text()='Azure role assignments']
${AD_User_AzureRoleAssignmentsHeader}  //span[text()=' | Azure role assignments']

${AD_NewUser}    //*[text()='New user']
${AD_Firstname}    (//*[text()='First name']//following::input)[1]
${AD_Lastname}    (//*[text()='Last name']//following::input)[1]
${AD_Name}    //*[contains(@placeholder,'Chris Green')]
${AD_Username}    //*[@aria-label='User name']
${AD_CreatePAssword}    //*[text()='Let me create the password']/../input/following-sibling::span[@class='azc-radio-circle']
${AD_InitialPassword}    (//*[contains(@class,'password')]/input[@type='password'])[1]
${AD_CreateUser}    //span[text()='Create']
${AD_DeleteUser}    //*[text()='Delete']
${AD_DeleteUserYes}    //*[text()='Yes']
${AD_DeleteUserList}    //*[text()='Deleted users (Preview)']


## Policy Page ###
${PolicyHeader}  //h2[text()='Policy']
${Policy_ViewAllLink}   //*[text()='View all']
${Policy_Filter}    //*[@placeholder='Filter by name or ID...']
${Policy_Subscription}  //*[@aria-label='Launch scope selector']
${Filter_Scuscription}  //div[@aria-label='Subscription' and @aria-expanded='true']
${Filter_Subscription_SelectAll}  //*[@aria-label='Subscription']/following-sibling::div/div/div[@aria-label='Select all']//div
${ScopeSelector}    //*[@aria-label='Launch scope selector']
${Subscription_Dropdown}    //*[@aria-label='Subscription' and @role='combobox']
${PolicySubscription_SelectAll}    //*[text()='Select all']/../div
${SelectSubscription}    //span[text()='Digital Surgery Platform QA']/../div
${Policy_ScopeClose}    //h2[text()='Scope']/following::button[@title='Close']
${Policy_EditAssignment}    //div[@title='Edit assignment']//div[text()='Edit assignment']

${Policy_Compliance}    //div[text()='Compliance']
${Policy_ComplianceHeader}    //span[text()=' | Compliance']
${SearchPolicy}    //*[@placeholder='Filter by name or ID...']
#${Policy_DS-Allow-VMs-Init}    //span[text()='${Policy_NameValue}']
#${PolicyHeader_DS-Allow-VMs-Init}    //h2[text()='${Policy_NameValue}']
#${PolicyComp_Name}    //label[text()='Name']/../following-sibling::div//div[@title='${Policy_NameValue}']
#${PolicyComp_Scope}    //label[text()='Scope']/../following-sibling::div//div[contains(@title,'${SubscriptionNameValue}')]
#${PolicyComp_Definition}    //label[text()='Definition']/../following-sibling::div//div[@title='${Policy_DefinitionValue}']
${InitiativeComp_Policies}    (//span[text()='Policies'])[1]
${SearchPolicyOrDefinition}    (//*[@placeholder='Filter by policy name or definition ID...'])[1]
${Policy_InitiativeCompliance}    //*[text()='Initiative compliance']
${Policy_InitativeName}    //*[text()='Effect Type']/following::div[text()='Deny' or text()='Audit']
${Policy_PolicyCompliance}    //*[text()='Policy compliance']
${Policy_ScopeName}    (//label[text()='Scope']/../following-sibling::div//div[@title='DSP MgmtGrp - Non-Prod (Rel 0.2.0)'])[2]
${Policy_ResourceCompliance}    (//span[text()='Resource compliance'])[1]
${Policy_Events}    (//span[text()='Events'])[1]
${Policy_ViewDefinition}    //*[text()='Policy compliance']/../following::div/div//ul//div/div[text()='View definition']
${PolicyDefinition}    //*[text()='Policy definition']
${PolicyDef_AvailableEffects}    //label[text()='Available Effects']/../following-sibling::div//div[@title='Deny']
${PolicyDef_Mode}    //label[text()='Mode']/../following-sibling::div//div[@title='All']
${PolicyDef_Type}    //label[text()='Type']/../following-sibling::div//div[@title='Custom']
${PolicyDef_Category}    //label[text()='Category']/../following-sibling::div//div[@title='General']
${Policydef_Definitions}    (//span[text()='Definition'])[1]
${Policydef_Assignments}    (//span[text()='Assignments (1)'])[1]
${PolicyViewDef}          //li[@title="View definition"]


${PolicyIntiativeComplainceSearch}  //*[@placeholder="Filter by policy name or definition ID..."]

### Activity Log Page ###
${ActivityLogHeader}  //h2[text()='Activity log']
${ActivityOperationName}  (//*[text()='Status']/following::div[@title='Succeeded'])[1]


### SecurityCenter Page ###

${DropdownValueSecurityCenter}    //*[text()="Security Center"]
${SecurityCenterHeader}    //h2[text()="Security Center"]
${SecurityCenter_Subtitle}    //h2[text()='Security Center']/following::div[contains(@class,'fxs-blade-title-subtitleText')]
${SecurityAlertButton}    //*[contains(@class,'menu-icon')]/following-sibling::div[text()='Security alerts']
${SecurityAlertHeader}    //*[text()=' | Security alerts']
${SecurityAlert_Subscription}  //*[text()='Description']/following::div[@class='azc-grid-tableContent']
${SecurityAlert_ActualDesc}  //*[text()='Description']/following::div//td[@aria-colindex='3']/div
${SecurityAlert_HeaderDesc}  (//a[text()='Security Center']/following::h2[contains(@class,'fxs-blade-title-titleText')])[2]
${SecurityCenter_Resource}  //*[text()='Attacked Resource']/following::div[@class='azc-grid-tableContent']
${SecurityAlert_ResourceHeader}  //h2[text()='Security alert']

${SecurityCenter_Settings}  //*[text()="Pricing & settings"]
${SecurityCenter_Settings_Header}  //*[text()=' | Pricing & settings']

### Monitor ###

${MonitorHeader}  //h2[text()='Monitor']
${ActivityLog_Tab}  //*[text()='Activity log']
${ActivityLog_Header}  //span[text()=' | Activity log']
${ActivityLog_FirstResult}  //span[text()='Operation name']/following::table[@role='presentation']//td[@aria-rowindex='1' and @aria-colindex='1']

${Logs_Tab}  //*[text()='Logs']
${Logs_Header}  //span[text()=' | Logs']
${Logs_ScopeClose}  //button[@aria-label="Close blade 'Select a scope'"]

${Monitor_KeyVaults_Tab}  //*[text()='Key Vaults']
${Monitor_KeyVaults_Header}  //span[text()=' | Key Vaults']

${Monitor_Containers_Tab}  //*[text()='Containers']
${Monitor_Containers_Header}  //span[text()=' | Containers']
${Monitor_Containers_MoniteredClusters}  //li[contains(text(),'Monitored clusters')]

${Monitor_StorageAccount_Tab}  //*[text()='Storage accounts']
${Monitor_StorageAccount_Header}  //span[text()=' | Storage accounts']

${Monitor_VirtualMachines_Tab}  //*[text()='Virtual Machines']
${Monitor_VirtualMachines_Header}  //span[text()=' | Virtual Machines']
${Monitor_VM_Performance}  (//*[text()='Refresh']/following::div[text()='Performance'])[1]

${Monitor_ServiceHealth_Tab}  //*[text()='Service Health']
${Monitor_ServiceHealth_Header}  //span[text()=' | Service Health']

${ServiceHealth_ServiceIssues_Tab}  //*[text()='Service issues']
${ServiceHealth_PlannedMaintenance_Tab}  //*[text()='Planned maintenance']
${ServiceHealth_HealthAdvisories_Tab}  //*[text()='Health advisories']
${ServiceHealth_SecurityAdvisories_Tab}  //*[text()='Security advisories']
${ServiceHealth_HealthHistory_Tab}  //*[text()='Health history']
${ServiceHealth_ResourceHealth_Tab}  //*[text()='Resource health']

${Monitor_Metrics_Tab}  //*[text()='Metrics']
${Monitor_Metrics_Header}  //span[text()=' | Metrics']

### Storage Accounts ###
${StorageAccountsHeader}  //h2[text()='Storage accounts']
${StorageAccount_Monitor}  //*[text()='Insights']
${StorageAccount_GeoReplication}  //span[contains(text()," | Geo-replication")]
${StorageAccount_Configuration}  //span[contains(text()," | Configuration")]
${StorageAccount_DataProtection}  //span[contains(text()," | Data protection")]
${StorageAccount_Encryption}  //span[contains(text()," | Encryption")]
${StorageAccount_DiagnosticSettings_Preview}  //span[contains(text()," | Diagnostic settings")]
${StorageAccount_DiagnosticSettings_Classic}  //span[contains(text()," | Diagnostic settings (classic)")]




### ACR ###
${ACRHeader}  //h2[text()='Container registries']
${ACR_MonitoringTab}  //*[text()='Metrics (Preview)']

### IoTHuB ###
${IotHubHeader}    //h2[text()='IoT Hub']
${IOTHUB_Metrics}    //*[text()='Metrics']
${MetricsHeader}    //*[text()=' | Metrics']

### Load Balancers ###
${LoadBalancersHeader}  //h2[text()='Load balancers']
${LoadBalancer_MonitoringTab}  //*[text()='Insights (preview)']

### Network Watcher ###
${NetworkWatcherHeader}    //h2[text()='Network Watcher']
${TopologyHeader}    //*[text()=' | Topology']
${Topology_ResourceGroup}    //*[text()='Select resource group']
${Topology_VirtualNetwork}    //*[text()='Select virtual network']
${Network_Topology}    //*[text()='Topology']



##Alerts
${AlertsHeader}    //h2[text()='Alerts']
${TimeRangeHeader}    //*[text()='Time range']
${DropDownTimeRange}    //*[text()='Time range']/following::div[@role='combobox']
${TimeRangeValue}    //span[text()='Past 30 days']
${ManageAlertRules}    //*[text()='Manage alert rules']
${RulesManagement_SubHeading}    //*[text()='Rules management']
${StatusHeader}    //*[text()='Status']
${DropDownStatus}    //*[text()='Status']/following::div[@role='combobox']
${Status_Disabled}    //*[text()='Disabled']
${Status_DisabledValue}    //*[text()='No results to display']
# ${Status_Enabled}    //*[text()='All statuses']/following::span[text()='Enabled']
${Status_Enabled}    //span[text()='Enabled']
${ManageAction}    //*[@aria-label='Manage actions']/following::div[text()='Manage actions']
${ManageAction_Header}    //h2[text()='Manage actions']
${ActionGroup}    //*[text()='Add action group']
${DropDownResourceGroup}    //label[text()='Resource group']/following::div[@aria-label='Create new or use existing Resource group' and @role='combobox']
${ResourceGroup_InputBox}    //input[@placeholder='Select existing...']
${ResourceGroup_Name}    //*[@placeholder='Select existing...']/following::span[text()='NA-DS-QA-AKS']
${ActionGroupName}    (//label[text()='Action group name']/../following::input[@type='text'])[1]
${NextNotification}    //*[text()='Next: Notifications >']
${Notifications}    //*[@title="Notifications"]
${DropDownNotificationType}    (//span[text()='Notification type']/following::div[@role='combobox' and @aria-label='Select a type'])[1]
${NotificationType_Value}    //*[text()='Email/SMS message/Push/Voice']
${Notification_Name}    //span[text()='Name']/following::input[@aria-label='Enter a description for the notification.']
${Email_checkbox}    //*[text()='Email']/preceding::div/input[@type='checkbox']/following-sibling::span
${Email_Text}    //*[text()='Email']/following::input[@aria-label='Email']
${Email_OK}    //*[@title='OK']
${ReviewCreate}    //*[@title='Review + create']
${Create}    //*[@title='Create']
${ManageAction_ResourceGroup}    //label[text()='Resource group']/../following-sibling::div/div[@class='azc-formElementContainer azc-validatableControl-none']//div[@role='combobox']
${ResourceGroup_AllGroup}    //*[text()='All resource groups']

## Virtual Peering

${VirtualNetworkHeader}    //h2[text()='Virtual networks']
${DropdownVirtualnetworkValue}   //*[text()="Virtual networks"]
${VirtualNetworkPeering}       //*[text()='Peerings']
${PrivateEndpoints}       //*[text()="Private endpoints"]

##Firewall

${FirewallsHeader}    //h2[text()='Firewalls']
${Firewall_Rules}    //*[text()='Rules']
${Rules_Header}    //*[text()=' | Rules']
${AddRules}    //*[text()='Add NAT rule collection']
${AddRule_Header}    //h2[text()='Add NAT rule collection']
${AddRule_Name}    //label[text()='Name']/../following-sibling::div//input
${AddRule_Priority}    //label[text()='Priority']/../following-sibling::div//input
${Rules_Name}    //div[text()='name']/../following::input[@aria-label='The value should not be empty.']
${Rules_Protocol}    (//div[text()='Protocol']/../following::div[contains(@class,'dropdown-multiselect')]/div//div[text()='0 selected'])[1]
${Rules_TCP}    //*[text()='TCP']/../div
${Rules_Source}    (//*[@placeholder='*, 192.168.10.1, 192.168.10.0/24, 192.168.10.2 – 192.168.10.10'])[1]
${Rules_DestinationAddress}    (//*[@placeholder='192.168.10.0'])[1]
${Rules_DestinationPort}    (//div[text()='Destination Ports']//ancestor::div[@class='fxc-gc-thead']/following-sibling::div[@class='fxc-gc-tbody']/div//input[@placeholder='8080'])[1]
${Rules_TranslatedPort}    (//div[text()='Translated port']//ancestor::div[@class='fxc-gc-thead']/following-sibling::div[@class='fxc-gc-tbody']/div//input[@placeholder='8080'])[2]
${Rules_TranslatedAddress}    (//*[@placeholder='192.168.10.0'])[2]
${Rules_AddButton}    //span[text()='Add']
${Rules_Refresh}    (//div[text()='Refresh'])[2]
${Edit_Rules}    (//*[text()='100']/following::td/a[@title='Context menu'])[1]
${Rules_EditButton}    //*[text()='Edit']
${Rules_Save}    //*[text()='Save']
${Rules_FirewallNotCreated}    (//*[text()='Failed to update the firewall'])[1]
${Notification_button}    //div[@class='fxs-topbar-notifications']/a[@title='Notifications']
${Dismiss_Notification}    //*[text()='Dismiss all']

## Web Application Firewall (WAF) Page ###
${WAFsHeader}  //h2[text()='Web Application Firewall policies (WAF)']
${WAFName}  //*[@class='fxc-gcflink-link' and text()='dsp-wafpolicy']
${WAFResource_header}  //h2[text()='dsp-wafpolicy']
${WAFResource_AssociatedAG}  //div[text()='Locks']/preceding::*[text()='Associated application gateways']


## Polciy ##
${Policy_EditAssignment}    //div[@title='Edit assignment']//div[text()='Edit assignment']
${Policy_EditInitativeAssignment}    //div[text()='Edit Initiative Assignment']
${EditInitiativeAssignment_AssignedBy}    //label[text()='Assigned by']
${EIAssignment_PEValue}    //li[@aria-checked="true"]/span[text()='Enabled']
# ${EIAssignment_PEValue}    //span[text()='Enabled']/../input[@checked='checked']
${EIAssignment_Cancel}    //span[text()='Cancel']
${Policy_SearchPolicyComp}    (//*[@placeholder='Filter by policy name or definition ID...'])[1]
${PolicyCompliance_EditAssignment}    (//div[@title='Edit assignment']//div[text()='Edit assignment'])[2]
${PolicyCompliance_PEValue}    //li[@aria-checked="true"]/span[text()='Enabled']




## Logout ]
${UserIcon}     //div[@class='fxs-avatarmenu-tenant-image-container']
${SignOutLink}  //*[@id="mectrl_body_signOut"]
${LogoutPage_Title}  //*[@id="loginHeader"]/div[1]


${ClickNext}  //*[@value="Next"]
${EmailID}  //*[@type="email"]
${Password}  //*[@type="password"]
${SubmitButton}  //*[@type="submit"]
${ButtonYes}  //*[@value="Yes"]
${AZSearchBox}  //*[@type="text"]
${AZSwitchDirectoryLink}  //*[@aria-label="Switch directory"]

#Common Links
${AZHome}  link:Microsoft Azure

#Avatar menu
${AvatarMenu}  class:fxs-avatarmenu-tenant-container
${LoginAccountSubscription}  //*[@id="mectrl_signedInTitle"]
${LoginAccountText}  //*[@id="mectrl_currentAccount_secondary"]
# ${LoginAccountID}  //*[@class="fxs-avatarmenu-username"]
${AZSwitchDirectoryLink}  //*[@aria-label="Switch directory"]

#All Resources
${AllResourcesSearch}  //*[@aria-label="text search filter"]


#Drop Down
${DropdownAllResources}  //*[text () ='All resources']
${DropdownPolicy}  //*[text () ='Policy']
${DropdownAppGateway}  //*[text()="Application gateways"]
${DropdownSecurityCenter}  //*[text()="Security Center"]
${DropDownSubscriptions}  //*[text () ='Subscriptions']
${DropdownServiceBus}  Microsoft_Azure_ServiceBus_ServiceBus
${DropdownFirewall}  //*[@class='fxs-menu-item fxs-search-menu-content'][contains(string(),'Firewalls')]
# ${DropdownKeyvault}  //div[text()="Key vaults"]
${DropdownPrivateDNS}  //*[@class='fxs-menu-item fxs-search-menu-content'][contains(string(),'Private DNS zones')]
${ADLogStorage}  link:dsnpdstgdev
# ${DropdownLog}  //*[text()="DS-QAAPPDEV-LGA"]
${DropdownLog}  //*[@class='fxs-menu-item fxs-search-menu-content'][contains(string(),'DS-QAAPPDEV-LGA')]
${DropdownPrivateLink}  //*[@class='fxs-menu-item fxs-search-menu-content'][contains(string(),'Private Link')]
${DropdownContainerRegistries}  Microsoft_Azure_ContainerRegistries_RegistryResource



${AZSubscriptionText}  //*[@class='fxs-menu-item fxs-search-menu-content'][contains(string(),'${Subscription}')]
${Resources}  link:Resources
#Common AD Groups Links
# ${ADGroupLink}  link:${ADGroupName}
${ADUserContributor}  //div[text()='${Contributor}']
${ADUserReader}  //div[text()='${Reader}']
${ADUserOwner}  //div[text()='${Owner}']
${MembersLink}  link:Members
${AccessControlLink}  link:Access control (IAM)

${Roles}  //span[text()='Roles']
${RoleSearch}  //input[@placeholder='Search by assignment name or description']
${RoleSelectReader}  //span[text()='${ReaderRole}']
${RoleSelectOwner}  //span[text()='${OwnerRole}']
${RoleSelectContributor}  //span[text()='${ContributorRole}']


#ADGroups
${ADGroupContributor}  link:DSP-MGMTGRP-CONTRIBUTOR
${ADGroupReader}  link:DSP-MGMTGRP-READER
${ADGroupOwner}  link:DS-MG-Owner
${ADACRLink}  link:dsnpdacr
${ADLogAnalyticsLink}  link:DS-QAAPPDEV-LGA
${ADLogTestStorageAcc}  dsnpdstgdev
${ADLogTestDropdown}  //span[text()='dsnpdstgdev']
${ADLogEventDropdown}  //span[text()='Events']
${ADLogStorageAccLog}  link:Storage accounts logs
${ADLogAdd}  //div[@class='azc-toolbarButton-label fxs-commandBar-item-text']
${ADLogSave}  //span[text()='Save']
${ADLogTestDataType}  //div[text()='Select data type...']
${ADLogTestMenu}  //div[@class='azc-formControl azc-input fxc-dropdown-open msportalfx-tooltip-overflow azc-validation-border fxc-dropdown-input']
${ADACRDATALink}  link:dsnpdacrdata
${ADRegistryResourceGroup}  link:NA-DS-QA-ACR-SH

${ServiceBusLink}  link:privatelink.servicebus.windows.net

${IOTLink}  link:DS-QA-IOT
${IOTTagsLink}  link:Tags
${IOTDeviceConfig}  link:IoT device configuration
${IOTTagCreated}  //span[text()='created-by']
${IOTTagEnv}  //span[text()='environment']
${IOTTagOwner}  //span[text()='owner']

${IOTReader}  //div[@class='fxc-infoBox-text msportalfx-tooltip-overflow'][contains(string(),'does not have authorization')]
${IOTEndpoint}  //input[text()='Endpoint=sb://iothub-ns-ds-qa-iot-4327831-09393a4cd4.servicebus.windows.net/;SharedAccessKeyName=iothubowner;SharedAccessKey=wi47x22RRLlUgJ7p+FyhExdjsde/DNYTSxx7ikchSz0=;EntityPath=ds-qa-iot-dev']
${IOTDPSLink}  link:DS-QA-IOTdps


#Keyvualt
# ${KVNAMELink}  link:ds-qa-vlt
# ${KVResourceGroup}  link:NA-DS-QA-KEY-SH
${KVKEYS}  link:Keys
${KVCERTIFICATES}  link:Certificates
${KVSECRETS}  link:Secrets
${KVACCESSPOLICIES}  link:Access policies
${KVNETWOKRING}  link:Networking
${KVPROPERTIES}  link:Properties
${DropdownKeyvault}  //*[text()="Key vaults"]
${KVFireWallAndVirtualNetworks}  //span[text()="Firewalls and virtual networks"]
${KVPrivateEndpointText}  //span[text()="Private endpoint connections"]
${KVCurrentPolicies}  //div[text()="Current Access Policies"]
${KVviewable}  //span[text()="Enabled"]

${KVPropertiesResourceID}  //*[@title="/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/resourceGroups/NA-DS-QA-KEY-SH/providers/Microsoft.KeyVault/vaults/ds-qaappdev-vlt"]
${KVPrivateEndpointApproved}  //div[text()="Approved"]
${Location}  //div[title()="East US"]
${BlobResourceGroupText}  link:NA-DS-QA-STG

${KVPrivateEndpointSucceeded}  //div[text()="Succeeded"]

#FireWall
${FWNAME}  link:DS-QA-PRM-FW
${FWResourceGroup}  link:NA-DS-QA-NWK-SH
# ${FWPrivateIPText}  //*[text()="172.22.0.4"]
# ${FWPublicIPText}  link:ds-qa-prm-fw-pip
${FWSubnet}  link:AzureFirewallSubnet
${FWVnet}  link:DS-QA-PRM-VNET
${FWPROPERTIES}  link:Properties
${FWPropertiesResourceID}  //*[@title="/subscriptions/3e6dbe4e-54bc-4571-b879-08a5011f22f1/resourceGroups/NA-DS-QA-NWK-SH/providers/Microsoft.Network/azureFirewalls/DS-QA-PRM-FW"]
${FWPropertiesName}  //*[@title="DS-QA-PRM-FW"]
${FWMRULES}  link:Rules (classic)
# ${FWRuleName}  link:DS-QA-NAT
# ${FWRuleText}  //div[text()="DS-QA-NAT"]
# ${FWRule4}  //div[text()='Apigee']
# ${FWRule4Translated}  //div[text()='10.187.230.4']
# ${FWRule4Port}  //div[text()='443']
# ${FWRule2}  //div[text()='Mirth']
# ${FWRule1}  //div[text()='JNJ-Inbound']
# ${FWRule3}  //div[text()='Hospital-SIM-SBX']
${Overview}  link:Overview
${NWKResourceGroup}  link:NA-DS-QA-NWK-SH

# ${PrivDNSBlob}  link:privatelink.blob.core.windows.net
# ${PrivDNSVaultCore}  link:privatelink.vaultcore.azure.net
# ${PrivDNSVaultCore}  link:privatelink.vaultcore.windows.net
# ${PrivDNSACR}  link:privatelink.azurecr.io
# ${PrivDNSMysql}  link:privatelink.mysql.database.azure.com
# ${PrivDNSServiceBus}  link:privatelink.servicebus.windows.net
# ${PrivDNSFileCore}  link:Privatelink.file.core.windows.net
${PrivDNSVirtNet}  link:Virtual network links
${PrivDNSProperties}  link:Properties
${PrivDNSVirtNetCompleted}  //div[text()='Completed']
${PrivDNSVirtNetPRM}  //div[text()='ds-qa-prm']
${PrivDNSVirtNetBlob}  //div[text()='privatelink.blob.core.windows.net-link']
${PrivDNSVirtNetMysql}  //div[text()='privatelink.mysql.database.azure.com-link']
${PrivDNSVirtNetACR}  //div[text()='privatelink.azurecr.io-link']
${PrivDNSVirtNetVaultCore}  //div[text()='privatelink.vaultcore.azure.net-link']
${PrivDNSVirtNetServiceBus}  //div[text()='privatelink.servicebus.windows.net-link']
${PrivDNSVirtNetPRMVNET}  link:DS-QA-PRM-VNET
${PrivDNSVirtNetVNET}  link:DS-QA-VNET
${PrivDNSVirtNetCompleted}  //div[text()='Completed']
${PrivDNSBlobResourceID}  //*[@title="/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/resourceGroups/NA-DS-QA-NWK-SH/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
${PrivDNSMysqlResourceID}  //*[@title="/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/resourceGroups/NA-DS-QA-NWK-SH/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com"]
${PrivDNSACRResourceID}  //*[@title="/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/resourceGroups/NA-DS-QA-NWK-SH/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"]
${PrivDNSVaultCoreResourceID}  //*[@title="/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/resourceGroups/NA-DS-QA-NWK-SH/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
${PrivDNSServiceBusResourceID}  //*[@title="/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/resourceGroups/NA-DS-QA-NWK-SH/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net"]

# ${PEKeyvault}  link:ds-qaappdev-vlt-pe
# ${PEAzureCR}  link:dsapddataacr-pe
# ${PEMysql}  link:dspdsqldev-pe
# ${PENamespace}  link:npnpdtdev-pe
# ${PEBlob}  link:dsnpdstgdev-pe
# ${PECassandra}  link:dsnpdcosdev-pe

# ${PEKeyvaultResource}  link:ds-qaappdev-vlt

# ${PEResourceGroup}  link:NA-DS-QA-NWK-SH
# ${PEVNET}  link:DS-QA-VNET/PVT
#${PESearch}  Private endpoint
${PEKeyvaultTarget}  //div[text()='vault']
${PEResourceID}  //*[@title="/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/resourceGroups/NA-DS-QA-NWK-SH/providers/Microsoft.Network/privateEndpoints/ds-qaappdev-vlt-pe"]
${PEProperties}  link:Properties
${PEKVLocation}  //div[text()="East US"]
${PEStatus}  //div[text()='Approved']
${PEState}  //div[text()='Succeeded']

${PLPrivEndpoints}  link:Private endpoints


###Login Page###
#${EmailID}  id:i0116
${EmailID}  //*[@type="email"]
${SubmitBtn}  //*[@type="submit"]
${PasswdField}  //*[@type="password"]
${PasswdFieldLoc}  //*[@type="password"]
${MoreInfo}  id:moreInfoUrl
${MFA}  id:signInAnotherWay
${Authenticate}  //*[text()='Approve a request on my Microsoft Authenticator app']
${NetOption}  link:Networking
${Notifications}  //*[@title='Notifications']
${Refresh}  //*[@title='Refresh']
${ContextMenu}  //*[@title='Click to open context menu']
${ContextMenu2}  //*[@title='Context menu']
${ResourceGroups}  link:Resource groups

###Validation###
${AZSearch}  class:azc-input
#${AZSearchBox}  class:azc-input
#${AZGroupSearch}  name:__azc-textBox-tsx0
${AZGroupsDropDown}  link:Groups
${AZGroupMembers}  //*[text()='Members']
${SubcriptionSearchBox}  //*[@placeholder='Search to filter items...']
${AZResourcesDropDown}  //*[text () ='All resources']
${AZResourcesText}  //*[text () ='Resources']
${FilterbyName}  //*[@placeholder='Filter by name...']
${Filter}  //input[@placeholder="Filter for any field..."]
${FilterName}  //input[@placeholder="Filter by name..."]
${FilterInventory}  //input[@placeholder="Filter by name"]
${FilterSubs}  //input[@placeholder="Search"]
${ASCResourceFilter}  //*[@placeholder='Filter by name']
${Roles}  //*[text ()='Roles']
${Retry}  link:Try again
${EncryptionOption}  link:Encryption
${SaveBtn}  //*[@title='Save']
${SaveBtnText}  //*[text ()='Save']
${OKBtn}  //*[text ()='OK']
${EncryptionSelectLoc}  //*[@value='Microsoft.Storage' and @checked='checked']
# ${EncryptionSelectLoc}  //*[@value='Microsoft.Storage' and @checked='checked']
${EncryptionSelectLoc}  //li[@aria-checked="true"]/input[@value="Microsoft.Storage"]
${ConfigurationLoc}  link:Cluster configuration
${RoleSearch}  //*[@placeholder='Search by assignment name or description']
${AZSecurity}  //*[text () = 'Azure Defender for Kubernetes']
${SecurityStatus}  //*[@data-bind='text: pricingStatus']
${MonitorDropDown}  //*[text () = 'Monitor']
${NameFilter}  //*[@placeholder="Search by name..."]
${SecurityCenter}  //*[text () = 'Security Center']
${ResourceHealth}  //*[text () = 'Resource health']

##Reader
${Group2Select}  //*[text()='883e7b39-3869-4ac6-ac7f-a4e6c4ac2f10']
${AZGroupMember2}  //*[text()='Yishak1 Desta1']
${ReaderRoleLoc}  //*[@aria-describedby="fxgridcol8"]
${ReaderRoleLink}  //*[text () ='Reader']
${AZReaderADGroup}  //*[text ()='DSP-MGMTGRP-READER']

##Contributor
${Group1Select}  //*[text()='e754d53a-cd9a-4615-905e-5b95deaf68dd']
${AZGroupMember1}  //*[text()='Yishak Desta']
${UserEmailID}  //*[text () ='Yishak.Desta@surgicalnet.io']
${ContributorRoleLoc}  //*[@aria-describedby="fxgridcol8"]
# ${ContributorRoleLink}  //*[text () ='Contributor']
${ContributorRoleLink}  link:Contributor
${AZContributorADGroup}  //*[text ()='DSP-MGMTGRP-CONTRIBUTOR']

## Azure Subscription
${AZSubscriptionText}  //*[text () ='${Subscription}']
${SubLink}  link:${Subscription}
${Resources}  link:Resources
${SubOverview}  link:Overview
${SubHeaderLink}  //*[@href='#@surgicalnet.io/resource/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/overview']
${SubscriptionDropDown}  //*[@aria-label="filter for Subscription, use 'Space' or 'Enter' key to enable edit mode"]
${SubscriptionsDropDown}  //*[text () ='Subscriptions']
${FilterSubscriptions}  //*[@placeholder='Search']

## DSEP Network
${AccessControl1}  link:Access control (IAM)
${VNET1Select}  //*[text () ='DS-QA-PRM-VNET']
${VNET1DropDown}  id:/subscriptions/b829a080-d3a3-4927-bcba-d44a12f67cc3/resourceGroups/NA-DS-QA-NWK-SH/providers/Microsoft.Network/virtualNetworks/DS-QA-PRM-VNET
${SubnetOption}  link:Subnets
${NewSubnetBtn}  //*[@title='Subnet']
${SubnetFilter}  //*[@placeholder='Search subnets']

## Blob Storage
${AccessControl2}  link:Access Control (IAM)
#${StorageAccountDropDown}  //*[@aria-label='Resources']
${ContainerOption}  //*[text ()='Containers']
${NewContainer}  //*[@title='New container']
${NewContainerName}  //*[@placeholder='']
#//*[@name='__azc-textBox-tsx2']
#${NewContainerSelect}  //*[@class='azc-grid-selectableRow-selectionCell azc-br-muted']
${NewElementSelect}  //*[text () ='robottest']
${FilterContainers}  //*[@placeholder='Search containers by prefix']
${DeleteContainerBtn}  //*[@title='Delete']
${CreateBtn}  //*[@data-formelement='pcControl: createButton']
${CloseBtn}  //*[@title='Close']
${OKBtn}  //*[text ()='OK']
${StorageAccountDropDown}  //*[text ()='dsnpdappdevstgsh']

## File Storage
${FSMenuOptions}  //*[@title='Context menu']
${DeleteFS}  //*[text ()='Delete share']
${InputTxt}  //*[@placeholder='']
${FSOption}  link:File shares
${NewFS}  //*[@title='New file share']
${NewFSInputTxt}  //*[@name='__azc-textBox-tsx2']
${FSCreateBtn}  //*[@data-formelement='pcControl: createOrUpdateButton']
${FSFilter}  //*[@placeholder='Search file shares by prefix (case-sensitive)']
${FSNewSelect}  //*[text ()='robottest']

##AKS Clusters
${AKSVMDropDown}  //*[@aria-label='Resources']
${NewInboundRule}  //span[text ()="Add inbound port rule"]
${NewInboundRuleBtnEnabled}  //div[@aria-disabled="false" and @title="Add inbound port rule"]
${NewInboundRuleBtnDisabled}  //div[@aria-disabled="true" and @title="Add inbound port rule"]
${InboundRuleDescription}  //*[@name='__azc-multiLineTextBox0']
${AddBtn}  //*[text ()='Add']
${NewAKSInboundRuleSelect}  //*[text ()=Port_8080]
${DeleteBtn}  //*[text ()='Delete']
${DeleteConfirmBtnY}  //*[text ()='Yes']
${AKSNodeSizeLoc}  //*[text ()='Integrations']
${AKSCapabilitiesLoc}  //*[text ()='Capabilities']
${AKSAutoScalingLoc}  //*[@data-bind='text: title' and text ()='Autoscaling']
${AKSAutoScalingConfigured}  //*[@data-bind='text: configuration.text' and text ()='Configured (2/2 node pools)']
${AKSRBACEnabled}  //*[@data-bind='text: rbacStatus' and text ()='Enabled']
${ContainersOption}  link:Containers
${Frame}  //*[@class='fxs-part-frame']
${Frame2}  //*[@class="fxs-part-frame fxs-portal-bg-txt-br fxs-reactview-frame-active fxs-blade-floated-menuframe fxs-blade-floated-frame"]
${ClusterMonitor}  //button[contains(text(),'View monitored clusters')]
#${AKSAutoScalingConfigured}  //*[text ()='Configured (2/2 node pools)']


##Azure Key Vault
${AZKeyVaultDropDown}  //*[text ()='ds-qaappdev-vlt']
${AZKeyVaultAccessCheck}  //*[@class='fxs-portal-border azc-optionPicker-item']

##Azure MYSQL Database
${AZMySQLDropDown}  //*[text ()='dspdsqldev']
${NewPasswordBtn}  //*[@title='Reset password']
${NewPasswordField}  //*[@placeholder='New password']
${ServerAdminLoginName}  //*[@title='mysqladmin@dspdsqldev']

##Azure Event Hub
${NewEventHub}  //*[@title='Event Hub']
${EventHubOption}  link:Event Hubs
${NewEventHubInputTxt}  //*[@placeholder='']
# //*[@name='__azc-textBox-tsx4']
${NewEventHubDelInputTxt}  //*[@placeholder='']
#//*[@name='__azc-textBox-tsx10']
${EventHubFilter}  //*[@placeholder='Search to filter items...']
${SelectNewEventHub}  //*[text ()='robottest']
${DeleteConfrimBtnDel}  //*[@title='Delete' and @role='button' and @class='fxs-button fxt-button fxs-inner-solid-border fxs-portal-button-primary']
${PVTEndpointConnectionsLink}  //*[text ()='Private endpoint connections']
${EH_Entities_EventsHubTab}  //span[contains(text()," | Event Hubs")]
${EH_Network_PrivateEndpointTab}  (//*[@role='tablist']//following::span/span[text()='Private endpoint connections'])[1]
${AccessControl3}  link:Access control (IAM)


#IOT
${AZIOT}  DS-QA-IOT
${AZIOTDropdown}  //*[text ()='DS-QA-IOT']
${IOTLink}  link:DS-QA-IOT
${IOTTagsLink}  link:Tags
${IOTDeviceConfig}  link:IoT device configuration
${IOTTagCreated}  //span[text()='created-by']
${IOTTagEnv}  //span[text()='environment']
${IOTTagOwner}  //span[text()='owner']


${AZHome}  link:Microsoft Azure
#Log Analytics
${ADLogStorage}  link:dsnpdstgdev
${ADLogAnalyticsLink}  link:DS-QAAPPDEV-LGA
${AZLogAnalytics}  DS-QAAPPDEV-LGA
${AZLogAnalyticsDropdown}  //*[text ()='DS-QAAPPDEV-LGA']
${ADLogTestStorageAcc}  dsnpdstgdev
${ADLogTestDropdown}  //span[text()='dsnpdstgdev']
${ADLogEventDropdown}  //span[text()='Events']
${ADLogStorageAccLog}  link:Storage accounts logs
${ADLogAdd}  //div[@class='azc-toolbarButton-label fxs-commandBar-item-text']
${ADLogSave}  //span[text()='Save']
${ADLogTestDataType}  //div[text()='Select data type...']
${ADLogTestMenu}  //div[@class='azc-formControl azc-input fxc-dropdown-open msportalfx-tooltip-overflow azc-validation-border fxc-dropdown-input']

${NoAccess}  //*[@title="No access"]
${ScopeConfigLink}  link:Scope Configurations (Preview)
${HasAddAccess}  //*[@title="Add"]
#ACR
${AZACR}  dsnpdappdevacr
${AZACRDropdown}  //*[text ()='dsnpdappdevacr']
#Service Bus
${AZServiceBus}  privatelink.servicebus.windows.net
${AZServiceBusDropdown}  //*[text ()='privatelink.servicebus.windows.net']

${IOTReader}  //div[@class='fxc-infoBox-text msportalfx-tooltip-overflow'][contains(string(),'does not have authorization')]
${IOTEndpoint}  //input[text()='Endpoint=sb://iothub-ns-ds-qa-iot-4327831-09393a4cd4.servicebus.windows.net/;SharedAccessKeyName=iothubowner;SharedAccessKey=wi47x22RRLlUgJ7p+FyhExdjsde/DNYTSxx7ikchSz0=;EntityPath=ds-qa-iot-dev']
${IOTDPSLink}  link:DS-QA-IOTdps
#Azure AD PIM
${IdentityGovDropDown}  //*[text ()='Identity Governance']
${AccessPackagesOption}  link:Access packages
${AccessPackageFilter}  //*[@placeholder='Search by access package name']
${PIMOption}  link:Azure AD roles
${ApproveReqOption}  link:Approve requests
${ApproveBtn}  //*[text ()='Approve']
${DenyBtn}  //*[text ()='Deny']
${StartTimeCol}  //*[text ()='Start time']
${EndTimeCol}  //*[text ()='End time']

##Azure RBAC
${ViewMyAccess}  //*[@title='Button: View my level of access to this resource.']

#Secureworks
${SWRGFilter}  //*[@placeholder='Filter for any field...']
${SWRGFilterRowItem}  //*[@class="fxc-gc-row-content fxc-gc-row-content_0"]


## Activity Log Vars ##
${timespan_filter}  //*[contains(text(),"Timespan")]
${timespan_LastMonth}  //input[@value=7]//following::span[1]


##Application Insights
${Json_View}  (//a[text()='JSON View'])[1]
${ResourceJson_Header}  //*[text()='Resource JSON']





${File_upload_Field}    //*[@type='file']
${Upload_Button}  //span[text()='Upload']

