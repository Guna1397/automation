Scenario: Org does not exist
    Given User is having updated contract information available
    When User makes call to Org API to update the organization
    And Specify fields (Org ID, Org Name, Contract details) that needs to be updated
    Then System shall error out the request
    And  Notify user that org does not exist