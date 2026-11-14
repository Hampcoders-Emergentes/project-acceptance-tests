# language: en

@user-story @us22 @ep03 @monitoring
Feature: Predictive maintenance recommendations
  As a store manager
  I want to receive predictive maintenance recommendations
  So that I can schedule reviews without affecting sales

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: System detects elevated wear
    Given "Oven 02" shows an elevated wear level
    And the failure probability is 0.82 with a configured limit of 0.70
    When the system evaluates the predictive maintenance
    Then the manager receives a maintenance recommendation for "Oven 02"
    And the recommendation suggests a window outside peak hours

  Scenario: Equipment has insufficient historical data
    Given "Freezer 03" has 4 historical measurements and 20 measurements are required
    When the system evaluates the failure probability
    Then the system waits for more measurements
    And the monitoring of "Freezer 03" remains reinforced

  Scenario: Equipment sensor does not report signal
    Given the sensor of "Freezer 03" is not reporting signal
    When the system evaluates the maintenance need
    Then the system recommends reviewing the connectivity before the maintenance

  Scenario Outline: Recommendation depends on the failure probability limit
    Given the failure probability for "Oven 02" is <probability> with a configured limit of 0.70
    When the system evaluates the predictive maintenance
    Then the maintenance recommendation is "<result>"

    Examples:
      | probability | result      |
      | 0.35        | NONE        |
      | 0.70        | NONE        |
      | 0.82        | RECOMMENDED |
