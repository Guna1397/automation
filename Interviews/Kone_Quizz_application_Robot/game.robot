*** Settings ***
Documentation     Automated tests for the Quiz App
Library           QuizApp.py



*** Variables ***

${question}     what s ur name?
${answer}       gunaseelan
${invalid_question}     Who are you
${choice}       6


*** Test Cases ***

User wants to display the question
    Given The user access the question
    When User wants to display the questions
    Then Verify the questions display


User wants to add and display the added question
    Given The user wants to add a question
    When User wants to display the question added
    Then Verify the question added

User wants to delete the question
    Given The user access the question
    When User wants to delete the question
    Then Verify the question deleted

User tires to enter invalid choice
    Given user enters the invalid choice
    When User should not get any choice
    Then Verify the error message

User wants to delete the question that doesnt exist
    Given The user access the question
    When User wants to delete the question that dont exist
    Then Verify the question cannot be deleted


*** Keywords ***
The user wants to add a question
    ${add_question}    add question        ${question}        ${answer}
    log to console  Question is : ${question}
    log to console    Answer is : ${answer}
    ${status}  Run Keyword And Return Status   should be equal    ${answer}    ${add_question["${question}"]}
    log to console    Question added successfully and the status is : ${status}

User wants to display the question added
    ${Questions_display}    display questions
    log to console    Questions are : ${Questions_display}

Verify the question added
    ${add_question}    add question        ${question}        ${answer}
    ${status}  Run Keyword And Return Status   should be equal    ${answer}    ${add_question["${question}"]}
    log to console    Question added successfully and the status is : ${status}

The user access the question
    log to console    User access the file which contains questions and answers

User wants to display the questions
    ${display_questions}      display questions
    log to console    The questions availabe are : ${display_questions}

Verify the questions display
    ${display_questions}      display questions
    ${status}  Run Keyword And Return Status   should not be empty    ${display_questions}
    log to console    Questions displayed successfully and the status is : ${status}

User wants to delete the question
    ${del_question}    delete question        ${question}
    log      Deleted Question is ${question}

Verify the question deleted
    ${display}  display questions
    log to console    ${display}

User wants to delete the question that dont exist
    ${del_question}    delete question    ${invalid_question}
    log to console    User tries to delete the invalid question

Verify the question cannot be deleted
    log     Question ${invalid_question}

user enters the invalid choice
     ${Invalid_choice}  whilefun    ${choice}
     log to console        ${Invalid_choice}

User should not get any choice

    log to console    User Entered Invalid choice

Verify the error message

    ${Invalid_choice}  whilefun    ${choice}
     log to console    ${Invalid_choice}










