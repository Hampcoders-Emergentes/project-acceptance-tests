# language: en

@user-story @us26 @ep04 @energy
Feature: Consumption outside business hours
  As a store manager
  I want to know the consumption registered outside business hours
  So that I can detect machines left on by mistake

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: System detects consumption outside business hours
    Given the store is closed and the idle mode limit is 0.5 kW
    And "Fryer 01" registers a consumption of 0.9 kW
    When the system evaluates the off-hours consumption
    Then the manager receives an unusual consumption alert for "Fryer 01"
    And the alert shows the equipment and the measurement time

  Scenario: Consumption remains within the idle mode
    Given the store is closed and the idle mode limit is 0.5 kW
    And "Fryer 01" registers a consumption of 0.2 kW
    When the system evaluates the off-hours consumption
    Then the system keeps the record without generating an alert

  Scenario: Sensor does not report signal during the night
    Given the sensor of "Freezer 03" is not reporting signal during the night
    When the system evaluates the night monitoring coverage
    Then the system reports the night monitoring of "Freezer 03" as unsupervised
    And the system recommends reviewing the sensor of "Freezer 03"

  Scenario Outline: Alert activation depends on the idle mode limit
    Given the store is closed and the idle mode limit is 0.5 kW
    And "Fryer 01" registers a consumption of <consumption> kW
    When the system evaluates the off-hours consumption
    Then the unusual consumption alert status is "<status>"

    Examples:
      | consumption | status   |
      | 0.2         | NO_ALERT |
      | 0.5         | NO_ALERT |
      | 2.4         | ALERT    |
