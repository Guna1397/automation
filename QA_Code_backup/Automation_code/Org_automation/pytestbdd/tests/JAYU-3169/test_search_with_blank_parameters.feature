Scenario:  Search with blank parameters
    Given User wants to retrieve Practitioner details using Practitioner API
    When API call is made with blank IDs
    Then API gives 200 response code
    And All Practitioners details are retrieved from DSP
