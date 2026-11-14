# language: en

@user-story @us42 @ep02 @safety
Feature: Temporary pause of the local panel interaction
  As a store worker
  I want to activate the temporary pause of the panel interaction
  So that I can clean the panel without triggering unintended actions

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Worker activates the interaction pause
    Given the worker "Lucia" starts cleaning the local panel
    When the worker activates the temporary interaction pause for 60 seconds
    Then the panel keeps the risk signal visible
    And the panel ignores interactions during 60 seconds

  Scenario: Critical alert occurs during the pause
    Given the temporary interaction pause is active
    When the sensor of "Fryer 01" reports a leakage current of 40 mA
    Then the panel interrupts the pause
    And the panel emits the audible alarm
    And the panel displays the instruction "MOVE AWAY FROM THE EQUIPMENT"

  Scenario: Worker activates the pause while the panel is offline
    Given the local panel is offline
    When the worker activates the temporary interaction pause
    Then the panel applies the pause locally
    And the panel queues the event for later synchronization

  Scenario Outline: The interaction pause ends automatically after the configured period
    Given the worker "Lucia" starts cleaning the local panel
    When the worker activates the temporary interaction pause for <seconds> seconds
    Then the panel ignores interactions for <seconds> seconds
    And the pause ends automatically after <seconds> seconds

    Examples:
      | seconds |
      | 30      |
      | 60      |
      | 120     |
