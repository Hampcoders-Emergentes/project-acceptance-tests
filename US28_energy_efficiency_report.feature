# language: en

@user-story @us28 @ep04 @energy
Feature: Energy efficiency report download
  As a store manager
  I want to download the energy consumption report
  So that I can present it in the cost review with management

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager downloads a report with data
    Given measurements exist in the requested period
    When the manager downloads the energy efficiency report
    Then the report includes the daily breakdown per equipment

  Scenario: Manager requests a report for a period without measurements
    Given no measurements exist in the requested period
    When the manager downloads the energy efficiency report
    Then the system displays the message "Report without data for the selected period."
    And the system offers the option to change the period

  Scenario: Report generation service does not respond
    Given the report generation service does not respond
    When the manager downloads the energy efficiency report
    Then the system displays the message "The request could not be processed. Please try again."
    And the system keeps the request as pending

  Scenario Outline: Efficiency report is generated in every supported format
    Given measurements exist in the requested period
    When the manager downloads the energy efficiency report in "<format>"
    Then the report is generated with content type "<contentType>"

    Examples:
      | format | contentType      |
      | CSV    | text/csv         |
      | PDF    | application/pdf  |
