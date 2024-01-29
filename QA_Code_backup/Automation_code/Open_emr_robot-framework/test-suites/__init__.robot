*** Settings ***
Documentation    Initialization Data

Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections

Suite Setup   Initialize Subscription Variable

Resource  CommonKeywords.robot

*** Keywords ***
Initialize Subscription Variable
    ${json}  Get file  ${basejsonfilepath}/subscription.json
    ${SUB}  Evaluate  json.loads('''${json}''')  json
    set Global Variable  ${subscription}  ${SUB["name"]}
    set Global Variable  ${SubscriptionID}  ${SUB["id"]}
    set Global Variable  ${AZPassword}  ${SUB["password"]}
    set Global Variable  ${AZUserReader}  ${SUB["userReader"]}
    set Global Variable  ${AZUserContributor}  ${SUB["userContributor"]}
    set Global Variable  ${AZUserOwner}  ${SUB["userOwner"]}

    set Global Variable  ${SubLocation}  ${SUB["location"]}
    set Global Variable  ${AZSubscriptionText}  //*[text () ='${subscription}']
    set Global Variable  ${SelectSubscription}    //span[text()='${subscription}']/../div
    set Global Variable  ${SubLink}  link:${subscription}
    Log To The Console  Subscription Variables Initialized
    ### AZ USERS ###

#AZ Subscription Users

    set Global Variable  ${SubHeaderLink}  //*[@href='#@surgicalnet.io/resource/subscriptions/${subscriptionID}/overview']

