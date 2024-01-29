*** Settings ***
## Author: Vishakha Pant

*** Variables ***
#set Default Varaibles
${env}
#File Path
${OnboardingPath}           ../dsp_daa_fhir_layering/configurationfiles/${env}/Infra/
${basejsonfilepath}         ../dsp_daa_fhir_layering/configurationfiles/${env}/Infra/
${subscription}             ../dsp_daa_fhir_layering/configurationfiles/${env}/base-infra/us_east

*** Keywords ***
Initialize Subscription Variable
    ${json}  Get file  ${basejsonfilepath}/subscription.json
    ${SUB}  Evaluate  json.loads('''${json}''')  json
    set Global Variable  ${subscription_name}  ${SUB["name"]}
    log to console   ${subscription_name}
    set Global Variable  ${SubscriptionID}  ${SUB["id"]}
    set Global Variable  ${AZPassword}  ${SUB["password"]}
    set Global Variable  ${AZUserReader}  ${SUB["userReader"]}
    set Global Variable  ${AZUserContributor}  ${SUB["userContributor"]}
    set Global Variable  ${AZUserOwner}  ${SUB["userOwner"]}

    set Global Variable  ${SubLocation}  ${SUB["location"]}
    set Global Variable  ${AZSubscriptionText}  //*[text () ='${subscription_name}']
    set Global Variable  ${SelectSubscription}    //span[text()='${subscription_name}']/../div
    set Global Variable  ${SubLink}  link:${subscription_name}
    Log To The Console  Subscription Variables Initialized

#AZ Subscription Users

    set Global Variable  ${SubHeaderLink}  //*[@href='#@surgicalnet.io/resource/subscriptions/${subscriptionID}/overview']

Initialize DocSpera Azure Functions Variable
    ${docspera_af_json_file}  Get file  ${OnboardingPath}docspera-azure-functions.json
    ${docspera_af_json_data}  Evaluate  json.loads('''${docspera_af_json_file}''')  json
    ${DOCSPERAAFTotal}=  Get Length  ${docspera_af_json_data}
    FOR  ${DOCSPERAAFCnt}  IN RANGE  ${DOCSPERAAFTotal}
        ## Variables for App Service Plan
        set Global Variable  ${DOCSPERAAFName${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_service_plan']['name']}
        set Global Variable  ${DOCSPERAAFResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_service_plan']['resource_group']}
        set Global Variable  ${DOCSPERAAFInstanceCount${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_service_plan']['instance_count']}
        set Global Variable  ${DOCSPERAAFRegion${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_service_plan']['region']}
        set Global Variable  ${DOCSPERAAFType${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_service_plan']['type']}
        set Global Variable  ${DOCSPERAAFPricingTier${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_service_plan']['pricing_tier']}

        # Variables for Function App1
        set Global Variable  ${DOCSPERAAFAppFunc1Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['name']}
        set Global Variable  ${DOCSPERAAFAppFunc1ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['resource_group']}
        set Global Variable  ${DOCSPERAAFAppFunc1Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['type']}
        set Global Variable  ${DOCSPERAAFAppFunc1PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['private_endpoint']}
        set Global Variable  ${DOCSPERAAFAppFunc1Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['region']}
        set Global Variable  ${DOCSPERAAFAppFunc1Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['version']}
        set Global Variable  ${DOCSPERAAFAppFunc1FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['ftp_state']}
        set Global Variable  ${DOCSPERAAFAppFunc1HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['https']}
        set Global Variable  ${DOCSPERAAFAppFunc1Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['diagnostic_storage']}
        set Global Variable  ${DOCSPERAAFAppFunc1Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['diagnostic_loganalytics']}
        set Global Variable  ${DOCSPERAAFAppFunc1AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['applications']}
        set Global Variable  ${DOCSPERAAFAppFunc1IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function1']['identity_system_assigned']}

        # Variables for Function App2
        set Global Variable  ${DOCSPERAAFAppFunc2Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc2ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['applications']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc2IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function2']['identity_system_assigned']}

        # Variables for Function App3
        set Global Variable  ${DOCSPERAAFAppFunc3Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc3ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['applications']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc3IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function3']['identity_system_assigned']}

        # Variables for Function App4
        set Global Variable  ${DOCSPERAAFAppFunc4Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc4ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['applications']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc4IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function4']['identity_system_assigned']}

        # Variables for Function App5
        set Global Variable  ${DOCSPERAAFAppFunc5Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc5ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['applications']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc5IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function5']['identity_system_assigned']}

        # Variables for Function App6
        set Global Variable  ${DOCSPERAAFAppFunc6Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc6ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['applications']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc6IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function6']['identity_system_assigned']}

        # Variables for Function App7
        set Global Variable  ${DOCSPERAAFAppFunc7Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc7ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc7IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['identity_system_assigned']}
        ...         ${status2}      Run Keyword And Return Status      Should Be Equal   ${${DOCSPERAAFAppFunc7Name${DOCSPERAAFCnt}}  DS-DEV-FUNC-DA-ID-GEN
        ...         Run Keyword If  ${status2}  set Global Variable   ${DOCSPERAAFAppFunc7AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function7']['applications']}


        # Variables for Function App8
        set Global Variable  ${DOCSPERAAFAppFunc8Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc8ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['applications']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc8IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function8']['identity_system_assigned']}

        # Variables for Function App9
        set Global Variable  ${DOCSPERAAFAppFunc9Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc9ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['applications']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc9IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function9']['identity_system_assigned']}

        # Variables for Function App10
        set Global Variable  ${DOCSPERAAFAppFunc10Name${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['name']}

        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAFAppFunc10ResourceGroup${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['resource_group']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10Type${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['type']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10PE${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['private_endpoint']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10Region${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['region']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10Version${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['version']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10FTPState${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['ftp_state']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10HTTPS${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['https']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10Diag_SA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['diagnostic_storage']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10Diag_LA${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['diagnostic_loganalytics']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10AppSetting}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['applications']}
        ...         set Global Variable  ${DOCSPERAAFAppFunc10IdentityStatus${DOCSPERAAFCnt}}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['app_function10']['identity_system_assigned']}

        # Variables for AD Groups
        Run Keyword Unless  "${env}" == "prd"
        ...         set Global Variable  ${DOCSPERAAF_ADGroups}  ${docspera_af_json_data[${DOCSPERAAFCnt}]['groups']}
        ...         set Global Variable  ${DOCSPERAAFLoc${DOCSPERAAFCnt}}  //*[text ()='${DOCSPERAAFName${DOCSPERAAFCnt}} ']

    END

Initialize Docspera Storage Account Variables
    ${daa_sa_json_file}  Get file  ${OnboardingPath}docspera-storage-accounts-daa.json
    ${daa_sa_json_data}  Evaluate  json.loads('''${daa_sa_json_file}''')  json
    ${DAA_SACntTotal}=  Get Length  ${daa_sa_json_data}
    FOR  ${DAA_SACnt}  IN RANGE  ${DAA_SACntTotal}
        set Global Variable  ${DAA_SA_Name${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['name']}
        set Global Variable  ${DAA_SARegion${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['region']}
        set Global Variable  ${DAA_SAResourceGroup${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['resource_group']}
        set Global Variable  ${DAA_SAKind${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['kind']}
        set Global Variable  ${DAA_SANetworkAccess${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['network_access']}
        set Global Variable  ${DAA_SAEncryptionType${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['encryption_type']}
        set Global Variable  ${DAA_SAVNETName${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['vnet']['name']}
        set Global Variable  ${DAA_SAVNETSubnetName${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['vnet']['subnet_details'][0]['name']}
        set Global Variable  ${DAA_SAVNETAddressRange${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['vnet']['subnet_details'][0]['address_range']}
        set Global Variable  ${DAA_SAGeoReplication${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['geo_replication']}
        set Global Variable  ${DAA_SAsecureTransfer${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['secure_transfer']}
        set Global Variable  ${DAA_SAsoftdelete_blob${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['soft_delete']['blobs']}
        set Global Variable  ${DAA_SAsoftdelete_days${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['soft_delete']['days']}
        set Global Variable  ${DAA_SALoc${DAA_SACnt}}  //*[text ()='${DAA_SA_Name${DAA_SACnt}}']
        set Global Variable  ${DAA_SAVNETName2${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['vnet2']['name']}
        set Global Variable  ${DAA_SAVNETSubnetDetails2${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['vnet2']['subnet_details']}
        set Global Variable  ${DAA_SAPrivateEndpoint${DAA_SACnt}}  ${daa_sa_json_data[${DAA_SACnt}]['private_endpoint']}
    END

    ${velysdl_sa_json_file}  Get file  ${OnboardingPath}docspera-storage-accounts-velysdl.json
    ${velysdl_sa_json_data}  Evaluate  json.loads('''${velysdl_sa_json_file}''')  json
    ${VELYSDL_SACntTotal}=  Get Length  ${velysdl_sa_json_data}
    FOR  ${VELYSDL_SACnt}  IN RANGE  ${VELYSDL_SACntTotal}
        set Global Variable  ${VELYSDL_SA_Name${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['name']}
        set Global Variable  ${VELYSDL_SARegion${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['region']}
        set Global Variable  ${VELYSDL_SAResourceGroup${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['resource_group']}
        set Global Variable  ${VELYSDL_SAKind${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['kind']}
        set Global Variable  ${VELYSDL_SANetworkAccess${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['network_access']}
        set Global Variable  ${VELYSDL_SAEncryptionType${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['encryption_type']}
        set Global Variable  ${VELYSDL_SAVNETName${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['vnet']['name']}
        set Global Variable  ${VELYSDL_SAVNETSubnetName${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['vnet']['subnet_details'][0]['name']}
        set Global Variable  ${VELYSDL_SAVNETAddressRange${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['vnet']['subnet_details'][0]['address_range']}
        set Global Variable  ${VELYSDL_SAGeoReplication${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['geo_replication']}
        set Global Variable  ${VELYSDL_SAsecureTransfer${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['secure_transfer']}
        set Global Variable  ${VELYSDL_SAsoftdelete_blob${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['soft_delete']['blobs']}
        set Global Variable  ${VELYSDL_SAsoftdelete_days${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['soft_delete']['days']}
        set Global Variable  ${VELYSDL_SALoc${VELYSDL_SACnt}}  //*[text ()='${VELYSDL_SA_Name${VELYSDL_SACnt}}']
        set Global Variable  ${VELYSDL_SAVNETName2${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['vnet2']['name']}
        set Global Variable  ${VELYSDL_SAVNETSubnetDetails2${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['vnet2']['subnet_details']}
        set Global Variable  ${VELYSDL_SAPrivateEndpoint${VELYSDL_SACnt}}  ${velysdl_sa_json_data[${VELYSDL_SACnt}]['private_endpoint']}
    END

    ${velysdsperadl_sa_json_file}  Get file  ${OnboardingPath}docspera-storage-accounts-velysdsperadl.json
    ${velysdsperadl_sa_json_data}  Evaluate  json.loads('''${velysdsperadl_sa_json_file}''')  json
    ${VELYSDSPERADL_SACntTotal}=  Get Length  ${velysdsperadl_sa_json_data}
    FOR  ${VELYSDSPERADL_SACnt}  IN RANGE  ${VELYSDSPERADL_SACntTotal}
        set Global Variable  ${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['name']}
        set Global Variable  ${VELYSDSPERADL_SARegion${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['region']}
        set Global Variable  ${VELYSDSPERADL_SAResourceGroup${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['resource_group']}
        set Global Variable  ${VELYSDSPERADL_SAKind${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['kind']}
        set Global Variable  ${VELYSDSPERADL_SANetworkAccess${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['network_access']}
        set Global Variable  ${VELYSDSPERADL_SAEncryptionType${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['encryption_type']}
        set Global Variable  ${VELYSDSPERADL_SAVNETName${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['vnet']['name']}
        set Global Variable  ${VELYSDSPERADL_SAVNETSubnetName${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['vnet']['subnet_details'][0]['name']}
        set Global Variable  ${VELYSDSPERADL_SAVNETAddressRange${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['vnet']['subnet_details'][0]['address_range']}
        set Global Variable  ${VELYSDSPERADL_SAGeoReplication${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['geo_replication']}
        set Global Variable  ${VELYSDSPERADL_SAsecureTransfer${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['secure_transfer']}
        set Global Variable  ${VELYSDSPERADL_SAsoftdelete_blob${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['soft_delete']['blobs']}
        set Global Variable  ${VELYSDSPERADL_SAsoftdelete_days${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['soft_delete']['days']}
        set Global Variable  ${VELYSDSPERADL_SALoc${VELYSDSPERADL_SACnt}}  //*[text ()='${VELYSDSPERADL_SA_Name${VELYSDSPERADL_SACnt}}']
        set Global Variable  ${VELYSDSPERADL_SAVNETName2${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['vnet2']['name']}
        set Global Variable  ${VELYSDSPERADL_SAVNETSubnetDetails2${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['vnet2']['subnet_details']}
        set Global Variable  ${VELYSDSPERADL_SAPrivateEndpoint${VELYSDSPERADL_SACnt}}  ${velysdsperadl_sa_json_data[${VELYSDSPERADL_SACnt}]['private_endpoint']}
    END


Initialize Docspera Storage_daa Account Variables
    ${docspera_sa_json_file}  Get file  ${OnboardingPath}docspera-storage-accounts-daa.json
    ${docspera_sa_json_data}  Evaluate  json.loads('''${docspera_sa_json_file}''')  json
    ${DOCSPERASACntTotal}=  Get Length  ${docspera_sa_json_data}
    FOR  ${DOCSPERASACnt}  IN RANGE  ${DOCSPERASACntTotal}
        set Global Variable  ${DOCSPERASAName${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['name']}
        set Global Variable  ${DOCSPERASAAccessTeir${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['access_tier']}
        set Global Variable  ${DOCSPERASAPerformance${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['performance']}
        set Global Variable  ${DOCSPERASARegion${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['region']}
        set Global Variable  ${DOCSPERASAResourceGroup${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['resource_group']}
        set Global Variable  ${DOCSPERASAKind${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['kind']}
        set Global Variable  ${DOCSPERASANetworkAccess${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['network_access']}
        set Global Variable  ${DOCSPERASAEncryptionType${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['encryption_type']}
        set Global Variable  ${DOCSPERASAVNETName${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['vnet']['name']}
        set Global Variable  ${DOCSPERASAVNETSubnetName${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['vnet']['subnet_details'][0]['name']}
        set Global Variable  ${DOCSPERASAVNETAddressRange${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['vnet']['subnet_details'][0]['address_range']}
        set Global Variable  ${DOCSPERASAGeoReplication${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['geo_replication']}
        set Global Variable  ${DOCSPERASAsecureTransfer${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['secure_transfer']}
        set Global Variable  ${DOCSPERASAsoftdelete_blob${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['soft_delete']['blobs']}
        set Global Variable  ${DOCSPERASAsoftdelete_days${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['soft_delete']['days']}
        #set Global Variable  ${DOCSPERASA_ADGroup}  ${docspera_sa_json_data[${DOCSPERASACnt}]['groups']}
        set Global Variable  ${DOCSPERASALoc${DOCSPERASACnt}}  //*[text ()='${DOCSPERASAName${DOCSPERASACnt}}']
        set Global Variable  ${DOCSPERASAVNETName2${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['vnet2']['name']}
        set Global Variable  ${DOCSPERASAVNETSubnetDetails2${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['vnet2']['subnet_details']}
        set Global Variable  ${DOCSPERASAPrivateEndpoint${DOCSPERASACnt}}  ${docspera_sa_json_data[${DOCSPERASACnt}]['private_endpoint']}
    END

Initialize Docspera Storage Account Groups Variables
    ${docspera_sagroups_json_file}  Get file  ${OnboardingPath}docspera-storage-accounts-groups.json
    ${docspera_sagroups_json_data}  Evaluate  json.loads('''${docspera_sagroups_json_file}''')  json
    ${DOCSPERASAGroupsCntTotal}=  Get Length  ${docspera_sagroups_json_data}
    FOR  ${DOCSPERASAGroupsCnt}  IN RANGE  ${DOCSPERASAGroupsCntTotal}
        set Global Variable  ${DOCSPERASAGroups_ADGroup}  ${docspera_sagroups_json_data[${DOCSPERASAGroupsCnt}]['groups']}
    END

Initialize DocSpera Key Vault Secret Variables
    ${docspera_kvs_json_file}  Get file  ${OnboardingPath}docspera-keyvault-secret.json
    ${docspera_kvs_json_data}  Evaluate  json.loads('''${docspera_kvs_json_file}''')  json
    ${DOCSPERAKVSCntTotal}=  Get Length  ${docspera_kvs_json_data}
    FOR  ${DOCSPERAKVSCnt}  IN RANGE  ${DOCSPERAKVSCntTotal}
        set Global Variable  ${DOCSPERASAName${DOCSPERAKVSCnt}}  ${docspera_kvs_json_data[${DOCSPERAKVSCnt}]['sa_name']}
        set Global Variable  ${DOCSPERAKVNAME${DOCSPERAKVSCnt}}  ${docspera_kvs_json_data[${DOCSPERAKVSCnt}]['keyvault_name']}
        set Global Variable  ${DOCSPERAKVSECRETS${DOCSPERAKVSCnt}}  ${docspera_kvs_json_data[${DOCSPERAKVSCnt}]['secrets']}
        set Global Variable  ${DOCSPERAKVSECRETEXP${DOCSPERAKVSCnt}}  ${docspera_kvs_json_data[${DOCSPERAKVSCnt}]['expiry-month']}
    END

Initialize Docspera Application Gateway Variables
    ${json}  Get file  ${OnboardingPath}docspera-appgwy.json
    ${AGDocspera}  Evaluate  json.loads('''${json}''')  json
    ${DOCSPERAAGCntTotal}=  Get length  ${AGDocspera}
    FOR  ${DOCSPERAAGCnt}  IN RANGE  ${DOCSPERAAGCntTotal}
        set Global Variable  ${ApplicationGatewaysNameValue}  ${AGDocspera[${DOCSPERAAGCnt}]['application_gateway_name']}
        set Global Variable  ${ApplicationGatewaysRegionValue}  ${AGDocspera[${DOCSPERAAGCnt1}]['region']}
        set Global Variable  ${ApplicationGatewaysRGValue}  ${AGDocspera[${DOCSPERAAGCnt1}]['resource_group']}
        set Global Variable  ${DocsperaAG_BackendPool}  ${AGDocspera[${DOCSPERAAGCnt}]['application_backendPool']}
        set Global Variable  ${DocsperaAG_Listner}  ${AGDocspera[${DOCSPERAAGCnt}]['application_listener']}
        set Global Variable  ${DocsperaAG_Rules}  ${AGDocspera[${DOCSPERAAGCnt}]['application_rules']}
        set Global Variable  ${DocsperaAG_HTTPSettings}  ${AGDocspera[${DOCSPERAAGCnt}]['application_HTTPSettings']}
        set Global Variable  ${DocsperaAG_HealthProbe}  ${AGDocspera[${DOCSPERAAGCnt}]['application_HealthProbe']}

    END

    ${json1}  Get file  ${OnboardingPath}docspera-appgwyorgpract.json
    ${AGDocspera1}  Evaluate  json.loads('''${json1}''')  json
    ${DOCSPERAAGCntTotal1}=  Get length  ${AGDocspera1}
    FOR  ${DOCSPERAAGCnt1}  IN RANGE  ${DOCSPERAAGCntTotal1}
        set Global Variable  ${ApplicationGatewaysNameValue1}  ${AGDocspera1[${DOCSPERAAGCnt1}]['application_gateway_name']}
        set Global Variable  ${DocsperaAG_BackendPool1}  ${AGDocspera1[${DOCSPERAAGCnt1}]['application_backendPool']}
        set Global Variable  ${DocsperaAG_Listner1}  ${AGDocspera1[${DOCSPERAAGCnt1}]['application_listener']}
        set Global Variable  ${DocsperaAG_Rules1}  ${AGDocspera1[${DOCSPERAAGCnt1}]['application_rules']}
        set Global Variable  ${DocsperaAG_HTTPSettings1}  ${AGDocspera1[${DOCSPERAAGCnt1}]['application_HTTPSettings']}
        set Global Variable  ${DocsperaAG_HealthProbe1}  ${AGDocspera1[${DOCSPERAAGCnt1}]['application_HealthProbe']}

    END

*** Variables ***
# ${AZPassword}  D$pazuread2021PS
${AZPassword}   Jnj@2021

#AZ Subscription Users
${AZUserReader}  Vishakha.Umashankar1@surgicalnet.io
${AZUserContributor}  Vishakha.Umashankar1@surgicalnet.io
# ${AZUserOwner}  Yishak.Desta1@surgicalnet.io
${AZUserOwner}  Vishakha.Umashankar1@surgicalnet.io

#AZ SVC Users
${DVCSVCReaderUser}  DSP.SVC.DVC.Test.User.Reader.npd@surgicalnet.io
${DVCSVCContributorUser}  DSP.SVC.DVC.Test.User.Contributor.npd@surgicalnet.io


## AZ URL ##
${AZURL}  https://portal.azure.com


## Config File Paths ##
${SharedPath}  ${basejsonfilepath}


## Wait Times ##
${Wait}  50s
${WaitTime}  30s



## AZ User IDs ##
${Contributor}  Yishak1 Desta1
${Reader}  A1 Noor1
${Owner}  Vishakha1 Umashankar1

## AZ Roles ##
${ContributorRole}  Contributor
${ReaderRole}  Reader
${OperatorRole}  Operator
${MonitorRole}  Monitor
${AdminRole}  Admin
${OwnerRole}  Owner

## AZ Status ##
${AvailableStatus}  Available
${AZSubStatus}  Active

## AZ Subscription Resource Vars ##
${Subscription}  DSP Sub - Non-Prod (Rel 0.2.0) – Development
${AZSubReaderScreenshotName}  SubscriptionReaderRole.png
${AZSubContributorScreenshotName}  SubscriptionContributorRole.png
${AZSubOwnerScreenshotName}  SubscriptionOwnerRole.png
${SubscriptionsFilterError}  None of the entries matched the given filter


