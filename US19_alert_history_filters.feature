# language: en

@user-story @us19 @ep03 @monitoring
Feature: Alert history with filters
  As a store manager
  I want to consult the alert history with filters by date, severity and equipment
  So that I can analyze recurring failure patterns

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager filters the alert history
    Given "Lima Norte" has alerts registered between "2026-11-01" and "2026-11-07"
    When the manager filters the alert history by severity "CRITICAL" and equipment "Fryer 01"
    Then the history lists only the alerts that match the filters
    And each alert shows its date, severity and equipment

  Scenario: Manager filters the alert history without results
    Given no alerts match the selected filters
    When the manager filters the alert history by severity "CRITICAL" and equipment "Freezer 03"
    Then the history displays the message "No alerts found for the selected filters."
    And the history offers the option to widen the date range

  Scenario: Manager consults the history without internet connection
    Given the internet connection is interrupted
    When the manager consults the alert history
    Then the history shows the last synchronized alerts
    And the history displays the notice "Data not up to date"

  Scenario Outline: Combined filters return only matching alerts
    Given the "Lima Norte" store has <total> alerts registered in the last 30 days
    When the manager filters the alert history by severity "<severity>" and equipment "<equipment>"
    Then the history returns <matching> alerts

    Examples:
      | total | severity | equipment  | matching |
      | 12    | CRITICAL | Fryer 01   | 3        |
      | 12    | WARNING  | Oven 02    | 0        |
      | 12    | CRITICAL | ALL        | 5        |
