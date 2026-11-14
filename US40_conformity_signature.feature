# language: en

@user-story @us40 @ep06 @access
Feature: Conformity signature registration
  As a store manager
  I want to register my conformity signature
  So that I can validate the downloadable inspection reports

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager registers a valid signature
    Given the signature file has an allowed format
    When the manager registers the conformity signature
    Then the system associates the signature with the manager account

  Scenario: Manager registers a signature with an invalid format
    Given the signature file has a disallowed format
    When the manager tries to register the conformity signature
    Then the system rejects the file
    And the system requests a valid format

  Scenario: System generates a report with the registered signature
    Given the manager has a registered signature
    When the manager downloads a compliance report
    Then the system includes the signature at the footer of the generated document

  Scenario Outline: Signature validation depends on the file format
    Given the signature file format is "<format>"
    When the manager registers the conformity signature
    Then the signature registration result is "<result>"
    And the system accepts the formats "PNG" and "JPG"

    Examples:
      | format | result   |
      | PNG    | accepted |
      | JPG    | accepted |
      | PDF    | rejected |
      | SVG    | rejected |
