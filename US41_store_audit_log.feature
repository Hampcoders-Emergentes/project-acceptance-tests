# language: en

@user-story @us41 @ep06 @access
Feature: Store action audit log
  As a store manager
  I want to consult the audit log of actions performed in the store
  So that I can verify who attended each alert

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager consults the audit log by date
    Given there are registered actions on the consulted date
    When the manager filters the audit log by date "2026-11-12"
    Then the log lists the time, the responsible user and the executed action

  Scenario: Consulted date has no registered actions
    Given there are no actions on the consulted date
    When the manager filters the audit log by date "2026-11-10"
    Then the log displays the message "No actions registered for the selected date."
    And the log offers the option to widen the date range

  Scenario: Manager consults the audit log without internet connection
    Given the internet connection is interrupted
    When the manager consults the audit log
    Then the log shows the last synchronized entries
    And the log displays the notice "Data not up to date"

  Scenario Outline: Audit log returns the actions of the selected date
    Given the audit log has <actions> actions on "2026-11-12"
    When the manager filters the audit log by date "2026-11-12"
    Then the log returns <actions> entries with the responsible user

    Examples:
      | actions |
      | 0       |
      | 3       |
      | 18      |
