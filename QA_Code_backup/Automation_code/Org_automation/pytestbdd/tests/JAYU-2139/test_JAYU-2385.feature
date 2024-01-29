Scenario: Payload is missing mandatory info with valid user role
    Given User needs to create an organization
    When Org payload is posted
    And Minimum Org information is provided such as Org Name, Org Address (city, state, country, zip), Org Phone, Fax, along with non mandatory info such as Alias ID
    Then System shall provide API based solution to consume the payload to create the organization within DSP
    And Error response is generated with 400 BAD REQUEST