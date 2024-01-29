Scenario: Valid data posted
    Given The data payload is posted by DocSpera
    When Payload is consumed by DSP
    Then System shall perform below validations (File format (must be in JSON), File Name format must be valid UUID, Presence of DocSpera ID in each data resource, USCDI specs) on data resource
    And System stores the data for further processing