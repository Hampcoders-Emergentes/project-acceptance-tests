# language: en

@user-story @us32 @ep05 @compliance
Feature: Maintenance record registration
  As a store manager
  I want to register the maintenance record issued by the technician
  So that I can keep the repair traceability for audits

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager registers a valid maintenance record
    Given the repair of "Fryer 01" is completed
    When the manager registers the technician maintenance record for "Fryer 01"
    Then the system updates the last maintenance date of "Fryer 01"

  Scenario: Manager registers a maintenance record with invalid data
    Given the maintenance record has invalid data
    When the manager tries to register the maintenance record for "Fryer 01"
    Then the system rejects the record
    And the system requests the correction of the invalid data

  Scenario: Manager registers the first maintenance record of an equipment
    Given "Oven 02" has no previous maintenance records
    When the manager registers the first maintenance record for "Oven 02"
    Then the system creates the maintenance history of "Oven 02"
    And the history shows the registered date

  Scenario Outline: Maintenance record validates mandatory data
    Given the maintenance record has "<case>"
    When the manager registers the maintenance record for "Fryer 01"
    Then the maintenance record result is "<result>"

    Examples:
      | case                          | result   |
      | a valid technician and date   | accepted |
      | no technician identified      | rejected |
      | a future maintenance date     | rejected |
