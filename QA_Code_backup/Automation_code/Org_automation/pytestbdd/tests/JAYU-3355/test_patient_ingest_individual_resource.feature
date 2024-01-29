Scenario:  Patient resource is ingested as individual resource
    Given User needs to ingest the patient data to DSP
    When Payload is posted to DSP
    Then System ingest the data within DSP
    And System generates the DSP ID for ingested resource
