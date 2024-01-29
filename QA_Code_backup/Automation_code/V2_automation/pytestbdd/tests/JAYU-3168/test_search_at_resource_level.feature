Scenario: Search at resource level
    Given Patient data is stored within DSP
    When User wants to access patient data at resource level
    And Access patient API using Patient DSP ID and resource name/resource ID
    Then System shall provide result back to user with matching records