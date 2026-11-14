# language: en

@user-story @us24 @ep04 @energy
Feature: Electrical consumption per equipment
  As a store manager
  I want to know the detailed electrical consumption per machine
  So that I can identify the equipment that raises the monthly bill

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager consults the consumption of a period with data
    Given "Lima Norte" has measurements for the period "2026-10-01" to "2026-10-31"
    When the manager consults the consumption per equipment
    Then the consumption shows the energy and estimated cost per machine

  Scenario: Manager consults a period without measurements
    Given the period "2026-09-01" to "2026-09-30" has no measurements
    When the manager consults the consumption per equipment
    Then the consumption displays the message "No data for the selected period."
    And the consumption offers the option to widen the date range

  Scenario: Manager consults the consumption with a silent sensor
    Given the sensor of "Oven 02" is not reporting signal
    When the manager consults the consumption per equipment
    Then the consumption shows partial data for "Oven 02"
    And the consumption displays the notice "Equipment unsupervised"

  Scenario Outline: Estimated cost is calculated from the measured energy
    Given the tariff is <tariff> PEN per kWh
    And "<equipment>" consumed <energy> kWh during the period
    When the manager consults the consumption per equipment
    Then the estimated cost for "<equipment>" is <cost> PEN

    Examples:
      | equipment  | energy | tariff | cost   |
      | Fryer 01   | 120    | 0.72   | 86.40  |
      | Oven 02    | 80     | 0.72   | 57.60  |
      | Freezer 03 | 240    | 0.72   | 172.80 |
