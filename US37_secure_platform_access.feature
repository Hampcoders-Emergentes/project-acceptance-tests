# language: en

@user-story @us37 @ep06 @access
Feature: Secure access to the web platform
  As a store manager
  I want to sign in with secure credentials
  So that I can protect the operational information of the store

  Background:
    Given the manager "Carlos" has an active account in the "Lima Norte" store

  Scenario: Manager signs in with valid credentials
    Given the manager enters valid credentials
    When the manager submits the sign-in form
    Then the system grants access to the store management

  Scenario: Manager signs in with invalid credentials
    Given the manager enters invalid credentials
    When the manager submits the sign-in form
    Then the system rejects the access
    And the system records the failed attempt

  Scenario: Account is locked after repeated attempts
    Given the account exceeds the allowed failed attempts
    When the manager tries to sign in
    Then the system keeps the temporary lock
    And the system informs the account recovery option

  Scenario Outline: Access result depends on the failed attempts
    Given the account has <failedAttempts> failed sign-in attempts
    And the maximum allowed failed attempts is 5
    When the manager submits valid credentials
    Then the access result is "<result>"

    Examples:
      | failedAttempts | result  |
      | 0              | GRANTED |
      | 4              | GRANTED |
      | 5              | LOCKED  |
