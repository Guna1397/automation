Scenario: User associates Org to one or multiple contracts with expired termination date
    Given User has org to be onboarded to DSP
    When User makes call to Org API to onboard the organization
    And User specifies (Contract ID,Contract Owner,Contract Effective Date,Contract Termination Date,Permitted Primary Use Categories,Secondary Use Flag,Permitted Secondary Use Categories,Data Classification Type,Permitted Geography,Franchise,Application or Device,Incident / Breach Notification SLA) mandatory fields in onboard request one or multiple times
    And Contract termination date for one of the contracts is <= current date
    Then System shall error out the request
    And Notify requestor about the error
