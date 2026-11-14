# language: en

@user-story @us20 @ep03 @monitoring
Feature: Alert assignment to a maintenance technician
  As a store manager
  I want to assign an alert to a maintenance technician
  So that I can schedule the timely review of the equipment

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager assigns a pending alert
    Given a pending alert "ALT-1042" exists for "Fryer 01"
    And the technician "Marco" is available
    When the manager assigns "ALT-1042" to "Marco"
    Then "Marco" receives the equipment detail with urgency "HIGH"
    And the alert shows a suggested deadline of "24 hours"

  Scenario: Selected technician is not available
    Given a pending alert "ALT-1042" exists for "Fryer 01"
    And the technician "Marco" is unavailable
    When the manager assigns "ALT-1042" to "Marco"
    Then the system suggests the alternate technician "Rosa"
    And the alert remains pending

  Scenario: Alert is already attended
    Given the alert "ALT-1042" is already attended
    When the manager assigns "ALT-1042" to "Marco"
    Then the system informs the attended status
    And the assignment attempt is linked to the existing case

  Scenario Outline: Suggested deadline depends on the alert severity
    Given a pending alert "ALT-1042" with severity "<severity>"
    And the technician "Marco" is available
    When the manager assigns "ALT-1042" to "Marco"
    Then the assignment urgency is "<urgency>"
    And the suggested deadline is "<deadline>"

    Examples:
      | severity | urgency | deadline |
      | CRITICAL | HIGH    | 4 hours  |
      | WARNING  | MEDIUM  | 24 hours |
      | INFO     | LOW     | 72 hours |
