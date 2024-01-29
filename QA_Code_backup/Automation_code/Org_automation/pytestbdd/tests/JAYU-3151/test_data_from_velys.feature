Scenario: Data coming from Velys
    Given Velys application has clinical data to be ingested into DSP
    When Velys application post the data to DSP
    Then System shall provide a solution to consume the clinical data payload from Velys application