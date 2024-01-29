*** Settings ***
Documentation    Suite description

Library  SeleniumLibrary
Library  Process
Library  OperatingSystem
Library  Collections
Library  RequestsLibrary
Resource        Variables.robot
*** Variables ***
${API_Output_filePath}              .${/}api_output_
${API_HTML_Output_Path}             D:\\Users\\DKasi\\OneDrive - JNJ\\Documents\\DocSpera\\Docspera_Automation_Final\\dsp_daa_fhir_layering
${API_Results_Path}                 ..${/}dsp_daa_fhir_layering${/}
${currElem}  0

*** Keywords ***
Create API Output file
    set global variable  @{Abc}  @{TEST TAGS}
    ${TC_ID}  Get Matches  ${Abc}  JAYU-*
    set global variable  ${TC_ID}  ${TC_ID}[0]
    set directory   ${API_HTML_Output_Path}
    Create File  .${/}api_output_${TC_ID}.txt
    append to file  ${API_Output_filePath}${TC_ID}.txt  Test_${TC_ID} Results${\n}

Create API Output Tag List
    set global variable  @{Abc}  @{TEST TAGS}
    ${TC_ID}  Get Matches  ${Abc}  JAYU-*
    set global variable  ${TC_ID}  ${TC_ID}[0]
    Create File  ${API_Results_Path}api_output_${TC_ID}.txt
    append to file  ${API_Results_Path}api_output_${TC_ID}.txt  Test_${TC_ID} Results${\n}

Remove Output files
    remove files       .${/}JAYU*.txt
    remove files       .${/}*.png
    remove files       .${/}api_output_*
    remove files       .${/}*.pdf
    remove files       .${/}*Test_Report.html

User has a Valid API Response
    ${result}=  generate api html report  ${TC_ID}
    Should Contain  ${result}  API Configuration Test Passed
