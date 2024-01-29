Scenario: Missing ORG ID or "From" date
    Given User wants to retrieve the data added
    When Search criteria (Valid Organization id, "From" date) is missing
    Then API gives 400 error response code