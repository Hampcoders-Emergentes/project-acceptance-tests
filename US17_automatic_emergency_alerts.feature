# language: en

@user-story @us17 @ep03 @monitoring
Feature: Automatic emergency alerts
  As a store manager
  I want to receive automatic alerts for overvoltages or energy leaks
  So that I can act quickly

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Overcurrent triggers an emergency alert
    Given "Fryer 01" has a maximum amperage threshold of 16 A
    And the sensor of "Fryer 01" reports an amperage of 24 A
    When the alert engine evaluates the measurement
    Then the manager receives an emergency alert for "Fryer 01" with severity "CRITICAL"

  Scenario: Primary notification channel is unavailable
    Given the primary notification channel "SMS" is unavailable
    And the manager has "EMAIL" as the alternate notification channel
    When the alert engine sends a critical alert
    Then the alert is delivered through "EMAIL"
    And the channel switch is recorded in the audit log

  Scenario: Equipment has no configured threshold
    Given "Oven 02" has no configured amperage threshold
    And the sensor of "Oven 02" reports an amperage of 22 A
    When the alert engine evaluates the measurement
    Then the alert engine applies the default amperage threshold of 16 A
    And the manager receives a pending configuration notice

  Scenario Outline: Alert severity depends on the measured amperage
    Given "Fryer 01" has a maximum amperage threshold of 16 A
    And the sensor of "Fryer 01" reports an amperage of <amperage> A
    When the alert engine evaluates the measurement
    Then the alert severity is "<severity>"

    Examples:
      | amperage | severity |
      | 12       | INFO     |
      | 18       | WARNING  |
      | 24       | CRITICAL |
