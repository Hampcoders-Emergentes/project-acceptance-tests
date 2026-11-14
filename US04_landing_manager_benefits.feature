# language: en

@user-story @us04 @ep01 @landing
Feature: Management benefits for the store administration
  As a visitor from the store manager segment
  I want to know the energy management and cost control benefits
  So that I can value the service subscription

  Background:
    Given the ElectroLink landing page is available

  Scenario: Manager visitor reads the management benefits
    When the visitor opens the "manager benefits" section of the landing page
    Then the page explains the energy savings
    And the page explains the operational continuity

  Scenario: Manager visitor sees an equipment without a configured threshold
    Given the example equipment "Oven 02" has no threshold configured
    When the visitor opens the "manager benefits" section of the landing page
    Then the page shows a pending configuration notice
    And the page explains the default threshold value

  Scenario: Manager visitor opens the web application from the management benefits
    Given the web application service is available
    When the visitor opens the "manager benefits" section of the landing page
    And the visitor selects the link to the web application
    Then the web application displays the sign-in page
