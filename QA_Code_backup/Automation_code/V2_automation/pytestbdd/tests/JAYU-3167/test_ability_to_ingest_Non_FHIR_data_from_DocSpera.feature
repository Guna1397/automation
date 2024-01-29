Scenario: Ability to ingest Non FHIR data from DocSpera
    Given User wants to add non-FHIR JSON (Checklist, Intake Form & Intake Smart Scheduler) from DocSpera to DSP
    When  DocSpera sends the non-FHIR JSON
    Then  Non-FHIR JSON is moved to DSP defined data tables
