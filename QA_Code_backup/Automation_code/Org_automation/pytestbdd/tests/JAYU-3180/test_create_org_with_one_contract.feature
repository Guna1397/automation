Scenario: User wants to associate Org to one contract
    Given User has org to be onboarded to DSP
    When User makes call to Org API to onboard the organization
    And User specifies (Contract ID,Contract Owner,Contract Effective Date,Contract Termination Date,Permitted Primary Use Categories,Secondary Use Flag,Permitted Secondary Use Categories,Data Classification Type,Permitted Geography,Franchise,Application or Device,Incident / Breach Notification SLA) mandatory fields as part of onboarding request
    And Contract termination date is not <= current date
    Then System shall store user specified contract information along with other Org details
