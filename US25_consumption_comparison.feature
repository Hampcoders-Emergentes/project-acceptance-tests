# language: en

@user-story @us25 @ep04 @energy
Feature: Consumption comparison between periods
  As a store manager
  I want to compare the energy expense between periods
  So that I can evaluate whether the savings measures are producing results

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager compares two periods with measurements
    Given both compared periods have measurements
    When the manager requests the monthly comparison
    Then the comparison shows the consumption and cost variation

  Scenario: One compared period has no measurements
    Given one of the compared periods has no measurements
    When the manager requests the monthly comparison
    Then the comparison displays a partial comparison notice
    And the comparison shows the available period data

  Scenario: Manager compares periods without internet connection
    Given the internet connection is interrupted
    When the manager requests the monthly comparison
    Then the comparison shows the last synchronized result
    And the comparison displays the notice "Data not up to date"

  Scenario Outline: Consumption variation is calculated between both periods
    Given the previous period consumed <previous> kWh
    And the current period consumed <current> kWh
    When the manager requests the monthly comparison
    Then the consumption variation is <variation> percent

    Examples:
      | previous | current | variation |
      | 1000     | 850     | -15.0     |
      | 1000     | 1000    | 0.0       |
      | 1000     | 1120    | 12.0      |
