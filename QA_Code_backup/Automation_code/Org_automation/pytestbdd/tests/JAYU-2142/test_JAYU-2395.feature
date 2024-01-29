Scenario: Invalid payload resulting in an error message - create.
    Given User is creating an Org
    When Data payload is not valid
    Then System shall throw an error message 400 BAD REQUEST