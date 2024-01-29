Scenario: Patient data does not exist
    Given Patient data is stored within DSP
    When  User wants to access patient data
    And  Access patient API using First Name, Last Name, Date of Birth
    Then System shall provide 0 result back to user
