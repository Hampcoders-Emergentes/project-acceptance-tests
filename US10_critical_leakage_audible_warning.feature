# language: en

@user-story @us10 @ep02 @safety
Feature: Local audible warning for a critical leakage
  As a store worker
  I want to receive a local audible warning for a critical leakage
  So that I can move away from the equipment quickly

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Critical leakage triggers the audible warning
    Given the sensor of "Fryer 01" reports a leakage current of 45 mA
    When the local panel evaluates the measurement
    Then the panel emits the audible alarm
    And the panel displays the instruction "MOVE AWAY FROM THE EQUIPMENT"

  Scenario: Critical leakage is detected while the panel is offline
    Given the local panel is offline
    And the sensor of "Fryer 01" reports a leakage current of 45 mA
    When the local panel evaluates the measurement
    Then the panel emits the audible alarm
    And the panel queues the event for later synchronization

  Scenario: Equipment does not report sensor signal
    Given the sensor of "Oven 02" is not reporting signal for 10 minutes
    When the local panel evaluates the supervision status
    Then the equipment risk level is "UNSUPERVISED"
    And the panel recommends reporting the case to the store manager

  Scenario Outline: Audible alarm activation depends on the leakage level
    Given the sensor of "Fryer 01" reports a leakage current of <leakage> mA
    When the local panel evaluates the measurement
    Then the audible alarm status is "<alarm>"
    And the panel displays "<instruction>"

    Examples:
      | leakage | alarm      | instruction               |
      | 12      | SILENT     | KEEP MONITORING           |
      | 35      | CONTINUOUS | MOVE AWAY FROM THE EQUIPMENT |
      | 60      | CONTINUOUS | MOVE AWAY FROM THE EQUIPMENT |
