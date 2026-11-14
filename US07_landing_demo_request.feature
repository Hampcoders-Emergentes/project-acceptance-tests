# language: en

@user-story @us07 @ep01 @landing
Feature: Demonstration request and commercial contact
  As a visitor
  I want to request a service demonstration through the contact data
  So that I can receive commercial attention and guided access to the web application

  Background:
    Given the ElectroLink landing page is available

  Scenario: Visitor requests a product demonstration
    When the visitor submits the demonstration request with valid contact data
    Then the page confirms the request
    And the page exposes a link to the web application

  Scenario: Visitor submits invalid contact data
    When the visitor submits the demonstration request with invalid contact data
    Then the page shows validation errors for the invalid fields
    And the page keeps the entered data for correction

  Scenario: Demonstration service does not respond
    Given the demonstration request service is unavailable
    When the visitor submits the demonstration request with valid contact data
    Then the page displays the message "The request could not be processed. Please try again."
    And the page preserves the entered contact data

  Scenario Outline: Contact data is validated before submission
    When the visitor submits the demonstration request with email "<email>" and phone "<phone>"
    Then the submission result is "<result>"

    Examples:
      | email                  | phone        | result   |
      | manager@electrolink.pe | +51987654321 | accepted |
      | manager@               | +51987654321 | rejected |
      | manager@electrolink.pe | 12345        | rejected |
