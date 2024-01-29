Scenario: Practitioner is existing within DSP
    Given Practitioner data is onboarded
    When Practitioner retrieval request is made by user for specific practitioner org
    And Practitioner ID is passed
    Then System shall provide a list/details of Org associated with Practitioner