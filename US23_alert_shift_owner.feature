# language: en

@user-story @us23 @ep03 @monitoring
Feature: Shift owner consultation during an alert
  As a store manager
  I want to know the shift owner during an alert
  So that I can perform the corresponding operational follow-up

  Background:
    Given the manager "Carlos" is signed in to the "Lima Norte" store

  Scenario: Manager consults an alert with a registered owner
    Given the alert "ALT-1042" is linked to shift "Morning" and owner "Lucia"
    When the manager consults the alert detail
    Then the detail shows the worker "Lucia" and the shift "Morning"

  Scenario: Alert has no identified owner
    Given the alert "ALT-1042" has no identified owner
    When the manager consults the alert detail
    Then the detail displays the notice "Owner not identified"
    And the detail offers the option to complete the record

  Scenario: Manager consults the owner without internet connection
    Given the internet connection is interrupted
    When the manager consults the owner of the alert "ALT-1042"
    Then the detail shows the last synchronized owner
    And the detail displays the notice "Verification pending"

  Scenario Outline: Alert detail resolves the owner for each shift
    Given the alert "ALT-1042" is linked to shift "<shift>" and owner "<owner>"
    When the manager consults the alert detail
    Then the detail shows the worker "<owner>" and the shift "<shift>"

    Examples:
      | shift     | owner |
      | Morning   | Lucia |
      | Afternoon | Diego |
      | Night     | Rosa  |
