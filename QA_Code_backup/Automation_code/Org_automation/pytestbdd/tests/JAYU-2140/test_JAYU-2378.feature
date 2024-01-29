Scenario: Org is not existing
    Given User needs to retrieve an organization
    When Retrieval request is made
    And Search criteria (any or combination) such as address (city, state, country), name, phone, DSP Org ID and Alias ID is passed
    Then System shall return the response with 404 NOT FOUND

