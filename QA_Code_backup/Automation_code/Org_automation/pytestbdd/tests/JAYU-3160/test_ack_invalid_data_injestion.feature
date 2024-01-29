Scenario: Data ingested errored out
    Given DocSpera post the data to DSP
    And DSP consumes the data
    When Data ingested errored out
    Then System shall provide notification to DocSpera about data error