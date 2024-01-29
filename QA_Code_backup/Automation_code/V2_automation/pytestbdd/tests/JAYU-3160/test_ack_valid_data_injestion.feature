Scenario: Data ingested successfully
    Given DocSpera post the data to DSP
    And DSP consumes the data
    When Data ingested successfully within DSP
    Then System shall provide notification to DocSpera about successful data ingestion