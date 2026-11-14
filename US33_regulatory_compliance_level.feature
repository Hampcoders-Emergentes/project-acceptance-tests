# language: en

@user-story @us33 @ep05 @compliance
Feature: Regulatory compliance level of the store
  As a store manager
  I want to know the regulatory compliance level of the store
  So that I can correct observations before an inspection

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store
    And the compliance level weights checklists at 40 percent, maintenance at 30 percent and monitoring coverage at 30 percent

  Scenario: Manager consults the compliance level with complete records
    Given the store has verification and maintenance records
    When the manager consults the regulatory compliance level
    Then the compliance level shows the global technical health percentage

  Scenario: Store has insufficient records for the calculation
    Given the store has few verification records
    When the manager consults the compliance level
    Then the compliance level shows a partial calculation
    And the compliance level lists the missing records

  Scenario: Several sensors do not report signal
    Given several sensors of the store do not report signal
    When the manager consults the compliance level
    Then the compliance level shows the calculated value
    And the compliance level displays the notice "Partial monitoring coverage"

  Scenario Outline: Compliance level is the weighted score of its components
    Given the checklist score is <checklist> percent
    And the maintenance score is <maintenance> percent
    And the monitoring coverage is <coverage> percent
    When the manager consults the regulatory compliance level
    Then the compliance level is <score> percent

    Examples:
      | checklist | maintenance | coverage | score |
      | 90        | 80          | 100      | 90.0  |
      | 70        | 60          | 80       | 70.0  |
      | 100       | 100         | 90       | 97.0  |
