Scenario: DocSpera_Velys - S3 export_naming format of DSP ID/Transaction ID  
    Given User has patient data that needs to be onboarded
    When Patient data is onboarded via Velys application (Non EMR workflow)
    Then Patient data should be stored within DSP
    And Patient Data is moved to DocSpera S3 container with transaction ID in below format "{dsep_d4c_patient_id}/{uuid}.json"