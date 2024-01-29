Scenario: When Patient data exists
    Given User wants to retrieve Patient details from DSP using MRN & organization ID
    When Valid MRN (Medical Record Number) & valid OID is passed in the API
    Then Patient is retrieved from DSP
    And API gives 200 response code returns the details of Patient FHIR resource