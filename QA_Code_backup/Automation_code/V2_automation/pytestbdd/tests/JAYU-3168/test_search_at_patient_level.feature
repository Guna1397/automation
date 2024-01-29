Scenario: Search at patient level
    Given Patient data is stored within DSP
    When User wants to access patient data
    And Access patient API using Patient DSP ID
    Then System shall provide result back to user with matching records