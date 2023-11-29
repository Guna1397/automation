Feature: ohrm

  Scenario Outline: Login to the portal
    Given Launch
    When Login with "<user>" and "<password>"
    And login
    Then Verify Logo

    Examples:
      | user  | password   |
      | admin | admin12345 |
      | Admin | admin123   |
      | dummy | dummy      |
