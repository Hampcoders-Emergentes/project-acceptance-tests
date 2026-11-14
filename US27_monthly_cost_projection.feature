# language: en

@user-story @us27 @ep04 @energy
Feature: Monthly electrical cost projection
  As a store manager
  I want to know the projected electrical cost at month end
  So that I can adjust the operating budget of the store

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager consults a projection with sufficient data
    Given the month has enough measurements for the estimate
    When the manager consults the cost projection
    Then the projection shows the estimated total with the current tariff

  Scenario: Month has insufficient data for the projection
    Given the month has few registered measurements
    When the manager consults the cost projection
    Then the projection displays a preliminary estimate notice
    And the projection suggests a date for a new consultation

  Scenario: Electrical tariff is not up to date
    Given the electrical tariff is not up to date
    When the manager consults the cost projection
    Then the projection uses the last available tariff
    And the projection displays the notice "Tariff update pending"

  Scenario Outline: Projected cost is calculated from the daily average
    Given the month has <days> elapsed days and an average daily consumption of <daily> kWh
    And the current tariff is <tariff> PEN per kWh
    When the manager consults the cost projection
    Then the projected monthly cost is <cost> PEN

    Examples:
      | days | daily | tariff | cost   |
      | 20   | 40    | 0.72   | 864.00 |
      | 10   | 30    | 0.72   | 648.00 |
      | 25   | 35    | 0.72   | 756.00 |
