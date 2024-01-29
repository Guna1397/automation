Scenario: Data coming from DocSpera
    Given User needs clinical data coming from DocSpera
    When DocSpera ingest the data to DSP by posting a payload
    Then System shall provide a solution to consume the clinical data payload from DocSpera