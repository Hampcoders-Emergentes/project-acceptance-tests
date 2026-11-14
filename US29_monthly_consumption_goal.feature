# language: en

@user-story @us29 @ep04 @energy
Feature: Monthly consumption goal per store
  As a store manager
  I want to define a monthly consumption goal for the store
  So that I can receive notices before exceeding the energy budget

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager defines a valid monthly goal
    Given the manager defines a monthly consumption goal of 5000 kWh with a warning at 80 percent
    When the manager saves the monthly goal
    Then the system accepts the goal
    And the system tracks the progress and warns at the configured percentage

  Scenario: Manager defines a goal outside the valid range
    Given the manager defines a monthly consumption goal of -100 kWh
    When the manager saves the monthly goal
    Then the system rejects the value
    And the system requests the correction of the goal

  Scenario: Consumption approaches the defined goal
    Given the monthly goal is 5000 kWh with a warning at 80 percent
    And the accumulated consumption is 4100 kWh
    When the system evaluates the monthly progress
    Then the system sends a budget warning with the current progress

  Scenario Outline: Goal status depends on the accumulated consumption
    Given the monthly goal is <goal> kWh with a warning at <threshold> percent
    And the accumulated consumption is <consumption> kWh
    When the system evaluates the monthly progress
    Then the goal status is "<status>"
    And the progress is <progress> percent

    Examples:
      | goal | threshold | consumption | status    | progress |
      | 5000 | 80        | 4100        | WARNING   | 82.0     |
      | 5000 | 80        | 3000        | ON_TRACK  | 60.0     |
      | 5000 | 80        | 5200        | EXCEEDED  | 104.0    |
