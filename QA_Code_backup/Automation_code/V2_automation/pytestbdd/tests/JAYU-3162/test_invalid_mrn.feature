Scenario: When Patient data does not exists
    Given User wants to retrieve Patient details from DSP using MRN & organization ID
    When Valid MRN (Medical Record Number) & valid OID is passed in the API
    Then API gives 200 response code
    And Returns 0 patient records