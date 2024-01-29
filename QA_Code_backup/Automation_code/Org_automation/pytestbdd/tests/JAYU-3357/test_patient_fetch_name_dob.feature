Scenario: Patient data exists
    Given Patient data is stored within DSP
    When  User wants to access patient data
    And  Access patient API using First Name, Last Name, Date of Birth
    Then System shall provide result back to user with matching records
