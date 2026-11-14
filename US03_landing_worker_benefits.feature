# language: en

@user-story @us03 @ep01 @landing
Feature: Operational safety benefits for store workers
  As a visitor from the store worker segment
  I want to know the operational safety benefits of ElectroLink
  So that I can value the protection during the kitchen shift

  Background:
    Given the ElectroLink landing page is available

  Scenario: Worker visitor reads the operational safety benefits
    When the visitor opens the "worker benefits" section of the landing page
    Then the page explains the early warning capability
    And the page explains the safe action protocol

  Scenario: Worker visitor sees an unsupervised equipment example
    Given the example sensor of "Fryer 01" is not reporting signal
    When the visitor opens the "worker benefits" section of the landing page
    Then the page shows the equipment as unsupervised
    And the page recommends reporting the case to the store manager

  Scenario: Visitor loses connectivity while reading the benefits
    Given the visitor has loaded the "worker benefits" section of the landing page
    When the landing page loses the internet connection
    Then the page displays a reconnection message
    And the already loaded benefits content remains available
