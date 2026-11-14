# language: en

@user-story @us36 @ep06 @access
Feature: Preferred notification channels
  As a store manager
  I want to choose the alert reception channels
  So that I can adapt the communication to my signal availability

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store
    And the manager has "SMS" as primary channel and "EMAIL" as alternate channel

  Scenario: Manager selects an available channel
    Given the primary notification channel "SMS" is available
    When the manager saves the notification preference
    Then the system routes the critical alerts to "SMS"

  Scenario: Primary channel is not available
    Given the primary notification channel "SMS" is unavailable
    When the system sends a critical alert
    Then the alert is delivered through "EMAIL"
    And the channel switch is recorded in the audit log

  Scenario: Manager has no defined preference
    Given the manager has no defined notification preference
    When the system sends an alert
    Then the system applies the default channel "DASHBOARD_PUSH"
    And the system informs the option to personalize the notification channel

  Scenario Outline: Critical alerts use the first available channel
    Given the primary notification channel "SMS" availability is "<availability>"
    When the system sends a critical alert
    Then the alert is delivered through "<delivered>"

    Examples:
      | availability | delivered |
      | available    | SMS       |
      | unavailable  | EMAIL     |
