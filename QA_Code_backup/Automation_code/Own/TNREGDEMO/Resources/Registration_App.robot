*** Settings ***
Resource    ./PO/LandingPage.robot
Resource    ./PO/EservicesPage.robot
Resource    ./PO/TopNav.robot

*** Variables ***


*** Keywords ***
Goto landingpage
    LandingPage.Goto page
    LandingPage.verify page loaded

Goto Eservices page
    TopNav.Select EservicesPage
    EservicesPage.verify page loaded
    EservicesPage.validation
Fill Eservices Page
    EservicesPage.Select Zone
    EservicesPage.Select District
    EservicesPage.Select SubRegistrarOffice
    EservicesPage.Select EC Details
    EservicesPage.Select Survey Details