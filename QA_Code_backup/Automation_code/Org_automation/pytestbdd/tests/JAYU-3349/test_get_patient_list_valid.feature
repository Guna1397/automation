Scenario: Patient(s) is existing within DSP
    Given Practitioner and Patient data is onboarded
    When Patient retrieval request is made by user for specific practitioner
    And Practitioner ID is passed
    Then System shall provide a list/details of patient associated with practitioner