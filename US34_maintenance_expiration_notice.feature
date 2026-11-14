# language: en

@user-story @us34 @ep05 @compliance
Feature: Maintenance expiration notice
  As a store manager
  I want to receive notices before the maintenance expiration of an equipment
  So that I can avoid operating machinery without certification

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager receives an upcoming expiration notice
    Given few days remain before the maintenance expiration of "Fryer 01"
    When the manager consults the task panel
    Then the notification shows the equipment "Fryer 01" and the expiration date

  Scenario: Equipment has no registered maintenance date
    Given "Oven 02" has no registered maintenance date
    When the system evaluates the maintenance expirations
    Then the system displays the notice "Maintenance date pending"
    And the system offers the option to register the maintenance date

  Scenario: Expiration notice is generated without internet connection
    Given the internet connection is interrupted
    When a maintenance expiration approaches
    Then the system keeps the notice locally
    And the system synchronizes the notice when the connection is restored

  Scenario Outline: Expiration notice level depends on the remaining days
    Given the maintenance of "Fryer 01" expires in <days> days
    When the system evaluates the maintenance expiration
    Then the expiration notice level is "<level>"

    Examples:
      | days | level   |
      | 30   | INFO    |
      | 7    | WARNING |
      | 0    | OVERDUE |
