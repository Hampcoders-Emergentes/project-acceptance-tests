# language: en

@user-story @us05 @ep01 @landing
Feature: Understanding the connected ecosystem
  As a visitor
  I want to understand how the sensor and analytics ecosystem works
  So that I can follow the flow from detection to alert

  Background:
    Given the ElectroLink landing page is available

  Scenario: Visitor understands the connected ecosystem
    When the visitor opens the "how it works" section of the landing page
    Then the page explains the measurement cycle
    And the page explains how alerts are generated

  Scenario: Visitor sees a disconnected sensor example
    Given the example sensor of "Freezer 03" loses the connection to the platform
    When the visitor opens the "how it works" section of the landing page
    Then the page shows the sensor as disconnected
    And the page explains the temporary local storage behavior

  Scenario: Multimedia content cannot load
    Given the ecosystem multimedia content is unavailable
    When the visitor opens the "how it works" section of the landing page
    Then the page shows the alternative textual description
    And the link to the web application remains available
