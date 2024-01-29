
*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${BROWSER}  chrome
${URL}  https://www.example.com
${SEARCH_TERM}  Robot Framework

*** Test Cases ***
Open Browser and Search
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Input Text  name=q  ${SEARCH_TERM}
    Click Button  name=btnK
    Sleep  2s
    Capture Page Screenshot
    Close Browser
