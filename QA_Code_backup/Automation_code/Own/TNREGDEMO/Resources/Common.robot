*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Keywords ***
Begin Test
    open browser   about:blank  ${BROWSER}   options=add_argument("--ignore-certificate-errors")
    maximize browser window

End Test
    close all browsers






