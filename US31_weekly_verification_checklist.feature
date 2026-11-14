# language: en

@user-story @us31 @ep05 @compliance
Feature: Weekly network verification checklist
  As a store manager
  I want to complete the weekly network verification checklist
  So that I can leave evidence of compliance with safety standards

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager completes the weekly checklist
    Given the week starts with a pending verification
    When the manager completes the checklist
    Then the system saves the record with the date and the responsible manager

  Scenario: Manager saves an incomplete checklist
    Given the checklist has unanswered questions
    When the manager tries to save the checklist
    Then the system informs the pending questions
    And the system keeps the progress as a draft

  Scenario: Manager completes the checklist without internet connection
    Given the internet connection is interrupted
    When the manager completes the checklist
    Then the system keeps the record locally
    And the system synchronizes the record when the connection is restored

  Scenario Outline: Checklist result depends on the answered questions
    Given the checklist has <answered> answered questions out of <total>
    When the manager saves the checklist
    Then the checklist status is "<status>"
    And the checklist shows <pending> pending questions

    Examples:
      | answered | total | status | pending |
      | 15       | 15    | SAVED  | 0       |
      | 12       | 15    | DRAFT  | 3       |
      | 0        | 15    | DRAFT  | 15      |
