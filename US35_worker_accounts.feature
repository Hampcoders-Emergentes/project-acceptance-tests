# language: en

@user-story @us35 @ep06 @access
Feature: Worker account registration
  As a store manager
  I want to register accounts for the kitchen workers
  So that they can be identified at the start of their shifts

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager registers a new worker account
    Given a new worker joins the "Lima Norte" store
    When the manager registers the worker employment data
    Then the system creates the account with a quick access credential for the store

  Scenario: Manager registers a worker with invalid data
    Given the worker data contains errors
    When the manager tries to register the worker account
    Then the system rejects the registration
    And the system requests the correction of the worker data

  Scenario: Manager registers a duplicated worker account
    Given an active account already exists for the same worker
    When the manager tries to register a new account
    Then the system informs the account duplication
    And the system keeps the existing account

  Scenario Outline: Worker account registration validates the employment data
    Given the worker data has "<case>"
    When the manager registers the worker account
    Then the registration result is "<result>"

    Examples:
      | case                     | result   |
      | a valid email and ID     | accepted |
      | an invalid email address | rejected |
      | a missing national ID    | rejected |
