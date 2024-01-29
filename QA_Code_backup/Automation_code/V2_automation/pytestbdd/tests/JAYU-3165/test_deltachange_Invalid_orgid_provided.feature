Scenario: Valid Org ID is not provided
    Given User wants to retrieve the data added
    When  Invalid organization ID is and "From" date in epoch format passed in API
    Then  API gives 200 response code
    And   Results back to user with 0 count