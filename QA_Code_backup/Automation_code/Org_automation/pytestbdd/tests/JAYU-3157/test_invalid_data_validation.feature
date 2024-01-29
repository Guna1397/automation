Scenario: Invalid data posted
    Given The data payload is posted by DocSpera
    When Payload is consumed by DSP
    Then System shall perform validations on data resource - File format (must be in JSON)
    Then System shall perform validations on data resource - File Name format (must be valid UUID)
    Then System shall perform validations on data resource - Presence of DocSpera ID in each data resource
    Then System shall perform validations on data resource - USCDI specs
    And  System stores errors as part of data processing
    And  System does not store the original data for further processing

