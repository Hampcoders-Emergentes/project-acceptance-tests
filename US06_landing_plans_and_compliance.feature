# language: en

@user-story @us06 @ep01 @landing
Feature: Subscription plans and regulatory compliance evidence
  As a visitor from the store manager segment
  I want to know the subscription plans and the evidence available for inspections
  So that I can evaluate hiring the service

  Background:
    Given the ElectroLink landing page is available

  Scenario: Manager visitor reads the subscription plans
    When the visitor opens the "plans" section of the landing page
    Then the page shows one subscription plan per store
    And the page shows the evidence available for regulatory inspections

  Scenario: Pricing information is unavailable
    Given the pricing service is unavailable
    When the visitor opens the "plans" section of the landing page
    Then the page displays the message "Pricing information is temporarily unavailable."
    And the page offers a contact option

  Scenario: Web application link fails from the plans section
    Given the web application service is unavailable
    When the visitor opens the "plans" section of the landing page
    And the visitor selects the link to the web application
    Then the page displays a retry message
    And the plans content remains available
