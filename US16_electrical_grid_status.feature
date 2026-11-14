# language: en

@user-story @us16 @ep03 @monitoring
Feature: Electrical grid status of the store
  As a store manager
  I want to know the electrical grid status of the store
  So that I can anticipate failures during peak hours

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager consults a healthy grid status
    Given the sensors of "Lima Norte" are reporting signal normally
    When the manager consults the electrical grid status
    Then the status shows the voltage and temperature of each equipment

  Scenario: Manager consults the grid status with a silent sensor
    Given the sensor of "Oven 02" is not reporting signal
    When the manager consults the electrical grid status
    Then the status shows "Oven 02" as unsupervised
    And the status recommends reviewing the sensor of "Oven 02"

  Scenario: Manager consults the grid status without internet connection
    Given the internet connection of the store is interrupted
    When the manager consults the electrical grid status
    Then the status shows the last synchronized readings
    And the status displays the notice "Data not up to date"

  Scenario Outline: Grid status reports voltage and temperature per equipment
    Given the sensor of "<equipment>" reports a voltage of <voltage> V and a temperature of <temperature> °C
    When the manager consults the electrical grid status
    Then the status reports <voltage> V and <temperature> °C for "<equipment>"

    Examples:
      | equipment  | voltage | temperature |
      | Fryer 01   | 220     | 65          |
      | Oven 02    | 218     | 180         |
      | Freezer 03 | 221     | 4           |
