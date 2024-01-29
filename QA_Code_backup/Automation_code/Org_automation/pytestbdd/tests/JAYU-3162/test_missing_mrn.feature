Scenario: Missing MRN number or OID
    Given User wants to retrieve Patient details from DSP using MRN & organization ID
    When During search MRN is missing
    Then API gives 400 response code
    And Returns no result back to user