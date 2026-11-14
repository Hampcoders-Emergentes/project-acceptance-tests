# language: en

@user-story @us30 @ep05 @compliance
Feature: Safety report download for regulatory inspection
  As a store manager
  I want to download the electrical safety event history
  So that I can present formal evidence during inspections

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager downloads a report with registered events
    Given safety events are registered in the requested period
    When the manager downloads the safety report
    Then the report contains the chronological record of attended alerts

  Scenario: Manager requests a report for a period without events
    Given no safety events exist in the requested period
    When the manager downloads the safety report
    Then the system displays the message "Report without data for the selected period."
    And the system offers the option to change the period

  Scenario: Report generation service does not respond
    Given the report generation service does not respond
    When the manager downloads the safety report
    Then the system displays the message "The request could not be processed. Please try again."
    And the system keeps the request as pending

  Scenario Outline: Safety report includes every event of the requested period
    Given the requested period contains <events> safety events
    When the manager downloads the safety report in "<format>"
    Then the report contains <events> events in chronological order

    Examples:
      | events | format |
      | 0      | PDF    |
      | 5      | PDF    |
      | 12     | CSV    |
