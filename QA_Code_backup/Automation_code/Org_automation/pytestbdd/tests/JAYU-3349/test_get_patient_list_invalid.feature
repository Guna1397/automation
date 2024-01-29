Scenario: Patient(s) does not exist within DSP
    Given Practitioner and Patient data is onboarded
    When  Patient retrieval request is made by user for specific practitioner
    And  Practitioner ID is passed
    Then  System shall provide a 0 result back to user