# language: en

@user-story @us18 @ep03 @monitoring
Feature: Temperature and amperage limits per equipment
  As a store manager
  I want to define the temperature and amperage limits per equipment
  So that I can adapt the alerts to each machine

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager defines valid limits
    Given the manager defines a temperature limit of 180 °C and an amperage limit of 14 A for "Fryer 01"
    When the manager saves the equipment configuration
    Then the system accepts the configuration
    And the system applies the new alert logic to "Fryer 01"

  Scenario: Manager defines a value outside the valid range
    Given the manager defines a temperature limit of 250 °C for "Fryer 01"
    When the manager saves the equipment configuration
    Then the system rejects the value
    And the system shows the allowed temperature range "120 to 200 °C"

  Scenario: Manager consults an equipment without a threshold
    Given "Oven 02" has no configured threshold
    When the manager consults the equipment configuration
    Then the system shows the default threshold values
    And the system shows the notice "Configuration pending"

  Scenario Outline: Limit validation depends on the equipment type
    Given the manager defines a temperature limit of <temperature> °C for a "<equipmentType>"
    And the manager defines an amperage limit of <amperage> A for the same equipment
    When the manager saves the equipment configuration
    Then the configuration result is "<result>"

    Examples:
      | equipmentType | temperature | amperage | result   |
      | fryer         | 180         | 14       | accepted |
      | fryer         | 250         | 14       | rejected |
      | oven          | 120         | 20       | accepted |
      | oven          | 110         | 20       | rejected |
