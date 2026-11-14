# language: en

@user-story @us12 @ep02 @safety
Feature: Safe shutdown protocol consultation
  As a store worker
  I want to know the safe shutdown protocol of an equipment
  So that I can act safely when an alert occurs

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Worker consults a defined shutdown protocol
    Given "Fryer 01" has a defined shutdown protocol
    When the worker requests the shutdown protocol for "Fryer 01"
    Then the panel lists the safe power-cut sequence for "Fryer 01"

  Scenario: Equipment has no defined shutdown protocol
    Given "Oven 02" has no defined shutdown protocol
    When the worker requests the shutdown protocol for "Oven 02"
    Then the panel indicates that the equipment must not be handled
    And the panel recommends reporting the case to the store manager

  Scenario: Worker consults a protocol while the panel is offline
    Given the local panel is offline
    And "Freezer 03" has a shutdown protocol stored locally
    When the worker requests the shutdown protocol for "Freezer 03"
    Then the panel returns the protocol from local storage

  Scenario Outline: Every defined protocol contains a complete power-cut sequence
    Given "<equipment>" has a defined shutdown protocol with <steps> steps
    When the worker requests the shutdown protocol for "<equipment>"
    Then the panel lists <steps> safe power-cut steps for "<equipment>"

    Examples:
      | equipment  | steps |
      | Fryer 01   | 4     |
      | Oven 02    | 3     |
      | Freezer 03 | 2     |
