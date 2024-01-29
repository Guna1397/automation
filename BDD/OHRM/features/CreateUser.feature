Feature: Use
  Scenario: Create User in HRM
    Given Launche
    When Login with username and password
    Then Create user
    And Verify user creation