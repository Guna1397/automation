Scenario:  Search with Invalid parameters
    Given User wants to retrieve Practitioner details using Practitioner API
    When API call is made using (Invalid NPI, Invalid DSP ID, First Name, Last Name) search parameters
    Then API gives 400 response error code
