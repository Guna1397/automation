*** Settings ***
Library    SeleniumLibrary


*** Variables ***


*** Keywords ***
Select eservicespage
    click element    xpath=//*[@id="8500009"]/a
    sleep    3s
    click element    xpath=//*[@id="8400001"]/a
    sleep    3s
    click element  xpath=//*[@id="8400010"]/a
    sleep    3s