*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LANDINGPAGE_VERIFY_ELEMENT} =    id=1195003

*** Keywords ***
Goto page
    go to  ${URL}
    click link    xpath=//*[@id="fontSelection"]
verify page loaded
    wait until page contains element    ${LANDINGPAGE_VERIFY_ELEMENT}
    log to console    Landing page verified successfully


