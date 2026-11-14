# language: en

@user-story @us21 @ep03 @monitoring
Feature: Sensor connectivity status
  As a store manager
  I want to know the connection status of each sensor
  So that I can ensure full monitoring coverage in the kitchen

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager consults the connectivity of every sensor
    Given the sensors of "Lima Norte" are reporting signal normally
    When the manager consults the sensor connectivity
    Then the connectivity shows each sensor as "CONNECTED"
    And the connectivity shows the equipment associated with each sensor

  Scenario: Sensor stops reporting signal
    Given the sensor "SNS-014" of "Fryer 01" stopped reporting signal 15 minutes ago
    When the system evaluates the expected communication
    Then the sensor status is "DISCONNECTED"
    And the connectivity shows the last signal time and the affected equipment "Fryer 01"

  Scenario: Manager consults connectivity without internet connection
    Given the internet connection of the store is interrupted
    When the manager consults the sensor connectivity
    Then the connectivity shows the last synchronized status
    And the connectivity displays the notice "Verification pending"

  Scenario Outline: Sensor status depends on the time since the last signal
    Given the sensor "SNS-014" associated with "Fryer 01" last reported <minutes> minutes ago
    When the manager consults the sensor connectivity
    Then the sensor status is "<status>"

    Examples:
      | minutes | status       |
      | 1       | CONNECTED    |
      | 5       | CONNECTED    |
      | 15      | DISCONNECTED |
