# language: en

@user-story @us13 @ep02 @safety
Feature: Equipment status registration at shift closure
  As a store worker
  I want to register the equipment status at shift closure
  So that I can leave a record for the next work team

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Worker closes the shift successfully
    Given the worker "Lucia" is identified in the current shift
    When the worker registers the shift closure with the equipment status
    Then the panel stores the closure with the worker "Lucia" and the closure time
    And the store manager receives the shift closure notification

  Scenario: Worker closes the shift while the panel is offline
    Given the local panel is offline
    When the worker registers the shift closure with the equipment status
    Then the panel stores the closure locally
    And the panel synchronizes the closure when the connection is restored

  Scenario: Shift closure without an identified worker
    Given no worker is identified in the current shift
    When the shift closure is registered
    Then the panel requests the responsible worker identification
    And the panel keeps the closure as pending

  Scenario Outline: Shift closure accepts every valid equipment status
    Given the worker "Lucia" is identified in the current shift
    And the equipment "Fryer 01" is "<equipmentStatus>"
    When the worker registers the shift closure with the equipment status
    Then the closure registers "Fryer 01" as "<equipmentStatus>"

    Examples:
      | equipmentStatus |
      | OK              |
      | WARNING         |
      | OUT_OF_SERVICE  |
