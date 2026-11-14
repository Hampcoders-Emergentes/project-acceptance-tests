# language: en

@user-story @us11 @ep02 @safety
Feature: Safe condition confirmation before cleaning
  As a store worker
  I want to confirm the safe condition of the area before cleaning
  So that I can clean without electrical risk

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Worker confirms a safe area
    Given the circuit of area "Grill" is isolated
    When the worker asks for the cleaning safety condition of area "Grill"
    Then the panel confirms that area "Grill" is safe for cleaning

  Scenario: Worker finds an unsafe area
    Given the circuit of area "Grill" remains energized
    When the worker asks for the cleaning safety condition of area "Grill"
    Then the panel indicates that cleaning is not allowed
    And the panel recommends reporting the case to the store manager

  Scenario: Area sensor does not report signal
    Given the sensor of area "Grill" is not reporting signal
    When the worker asks for the cleaning safety condition of area "Grill"
    Then the panel shows the area as unverified for cleaning
    And the panel recommends not cleaning the area

  Scenario Outline: Cleaning safety status derives from the circuit condition
    Given the circuit of area "<area>" is <condition>
    When the worker asks for the cleaning safety condition of area "<area>"
    Then the cleaning safety status is "<status>"

    Examples:
      | area     | condition  | status            |
      | Grill    | isolated   | SAFE_FOR_CLEANING |
      | Fryer    | energized  | NOT_SAFE          |
      | Prep     | isolated   | SAFE_FOR_CLEANING |
