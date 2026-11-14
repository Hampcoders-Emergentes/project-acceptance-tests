# language: en

@user-story @us39 @ep06 @access
Feature: Equipment ordering according to the kitchen layout
  As a store manager
  I want to order the equipment according to the real kitchen layout
  So that I can locate the failing machine quickly

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store
    And the store has registered equipment

  Scenario: Manager registers the equipment positions
    Given the manager assigns position "A1" to "Fryer 01"
    And the manager assigns position "B2" to "Oven 02"
    When the manager saves the kitchen layout
    Then the system keeps the spatial layout of the store

  Scenario: Two equipment share the same position
    Given the manager assigns position "A1" to "Fryer 01"
    And the manager assigns position "A1" to "Oven 02"
    When the manager saves the kitchen layout
    Then the system informs the duplicated position
    And the system requests the correction of the equipment position

  Scenario: Equipment has no registered position
    Given "Freezer 03" has no registered position
    When the manager consults the kitchen layout
    Then the layout shows "Freezer 03" in the pending position list

  Scenario Outline: Layout validation depends on the assigned position
    Given the manager assigns position "<position>" to "<equipment>"
    When the manager saves the kitchen layout
    Then the layout result is "<result>"

    Examples:
      | equipment  | position | result   |
      | Fryer 01   | A1       | accepted |
      | Oven 02    | A1       | rejected |
      | Freezer 03 | B2       | accepted |
