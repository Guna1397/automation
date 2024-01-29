*** Settings ***
Library    SeleniumLibrary
Library    JSONLibrary
Library    os
Library    Collections


*** Variables ***
${eservicesPage_verification}=   css=#EncumbranceCertificateForm > div.container > div > h2



*** Keywords ***
verify page loaded
    wait until page contains element    ${eservicesPage_verification}
    sleep    3s

validation
    element text should be  ${eservicesPage_verification}   Search Encumbrance Certificate
    log to console    Eservices page verified successfully

Select Zone
    select from list by label    id=cmb_Zone    Chennai
Select District
    select from list by label    name=cmb_District    Thiruvalur
Select SubRegistrarOffice
    select from list by label    name=cmb_SroName    Tiruvallur Joint 1
Select EC Details
     ${json_obj} =    load json from file    Resources/JSON/50.json
   # ${EC}     @{json_obj["EC"]}
    click element    xpath=//*[@id="txt_PeriodStartDt"]
    #${json_obj} =    load json from file    C:/Users/vjric/PycharmProjects/TNREGDEMO/Resources/JSON/SurveyDetails.json
   ${ecstartdate} =    get value from json    ${json_obj}    $.EC.startdate
    input text    id=txt_PeriodStartDt   ${ecstartdate}
    click element    xpath=//*[@id="txt_PeriodEndDt"]
   # ${json_obj} =    load json from file    C:/Users/vjric/PycharmProjects/TNREGDEMO/Resources/JSON/SurveyDetails.json
    ${ecenddate} =    get value from json    ${json_obj}    $.EC.enddate
    input text    id=txt_PeriodEndDt   ${ecenddate}


#*** Test Cases ***

Select Survey Details

   &{json_obj} =    load json from file    Resources/JSON/dump.json
    FOR    ${robot}    IN    @{json_obj["Survey Details"]}
        #Log    ${robot["Village"]}
        #Log    ${robot["Surveynumber"}
        select from list by label    name=cmb_Village   ${robot["Village"]}
        input text    id=txt_SurveyNo    ${robot["Surveynumber"]}
        input text    id=txt_SubDivisionNo   ${robot["Subdivisionnum"]}
        click element    xpath=//*[@id="btn_AddSurvey"]
    END
    mouse over    xpath=//*[@id="incCaptcha"]
    sleep    5s
    mouse over    xpath=//*[@id="btn_SearchDoc"]
    log to console    Survey Details added successfully
