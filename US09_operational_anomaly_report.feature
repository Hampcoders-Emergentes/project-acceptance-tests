# language: en

@user-story @us09 @ep02 @safety
Feature: Operational anomaly report
  As a store worker
  I want to report a perceived anomaly in an equipment
  So that I can alert the store manager without interrupting customer service

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Worker reports an anomaly successfully
    Given the worker "Lucia" perceives an unusual noise in "Fryer 01"
    When the worker registers the operational report for "Fryer 01"
    Then the store manager receives the alert with equipment "Fryer 01", the report time and the shift owner "Lucia"

  Scenario: Worker reports an anomaly while the panel is offline
    Given the local panel is offline
    When the worker registers the operational report for "Fryer 01"
    Then the panel stores the report locally
    And the panel synchronizes the report when the connection is restored

  Scenario: Worker reports an anomaly already registered
    Given an open report exists for "Fryer 01"
    When the worker registers another operational report for "Fryer 01"
    Then the new report is linked to the existing case
    And the panel confirms the report registration to the worker

  Scenario Outline: Report category depends on the perceived anomaly
    Given the worker "Lucia" perceives <anomaly> in "<equipment>"
    When the worker registers the operational report for "<equipment>"
    Then the report is classified as "<category>"

    Examples:
      | equipment  | anomaly                  | category    |
      | Fryer 01   | an unusual noise         | NOISE       |
      | Oven 02    | an overheating smell     | OVERHEATING |
      | Freezer 03 | a small water leak       | WATER       |
