Scenario: Org is existing
    Given User needs to retrieve an organization
    When Retrieval request is made
    And Search criteria (any or combination) such as address (city, state, country), name, phone, DSP Org ID and Alias ID is passed
    Then System shall provide API based solution to retrieve an Org
    And Success response is generated with Org data
