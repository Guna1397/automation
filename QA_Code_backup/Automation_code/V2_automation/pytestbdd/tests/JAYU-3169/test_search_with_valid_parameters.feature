Scenario: Search with valid parameters
    Given  User wants to retrieve Practitioner details using Practitioner API
    When API call is made using (Valid NPI, Valid DSP ID, First Name, Last Name) search parameters
    Then API gives 200 response code
    And Practitioner details with matching record is provided to user
