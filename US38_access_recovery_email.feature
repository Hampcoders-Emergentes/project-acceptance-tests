# language: en

@user-story @us38 @ep06 @access
Feature: Access recovery by email
  As a store manager
  I want to recover my access through email
  So that I can reset my password securely

  Background:
    Given the manager "Carlos" has an account in the "Lima Norte" store

  Scenario: Manager requests a password recovery
    Given the email "carlos@electrolink.pe" is registered in the platform
    When the manager requests the password recovery
    Then the manager receives a secure reset link with limited validity of 15 minutes

  Scenario: Manager requests a recovery for an unregistered email
    Given the email "unknown@electrolink.pe" is not registered in the platform
    When the manager requests the password recovery
    Then the system displays the message "Email not registered."
    And the system offers the contact support option

  Scenario: Manager uses an expired reset link
    Given the reset link exceeds the allowed validity
    When the manager tries to use the reset link
    Then the system rejects the link
    And the system offers the generation of a new reset link

  Scenario Outline: Reset link validity depends on its age
    Given the reset link was generated <minutes> minutes ago
    When the manager uses the reset link
    Then the reset link status is "<status>"

    Examples:
      | minutes | status  |
      | 10      | VALID   |
      | 15      | VALID   |
      | 30      | EXPIRED |
