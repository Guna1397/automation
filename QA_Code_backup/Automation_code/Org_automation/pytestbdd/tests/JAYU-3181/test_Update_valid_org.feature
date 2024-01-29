Scenario: Org existing
    Given User is having updated contract information available
    When User makes call to Org API to update the organization
    And Specify fields (Org ID, Org Name, Contract details) that needs to be updated
    Then System shall update contract information
