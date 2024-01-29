Scenario: Practitioner does not exist within DSP
    Given Practitioner data is onboarded
    When Practitioner retrieval request is made by user for specific practitioner org
    And Practitioner ID is passed
    Then  System shall provide a 0 result back to user