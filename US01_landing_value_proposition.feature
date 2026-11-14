# language: en

@user-story @us01 @ep01 @landing
Feature: Landing value proposition and access to the web application
  As a visitor
  I want to understand the ElectroLink value proposition on the landing page
  So that I can open the web application and explore the electrical monitoring

  Background:
    Given the ElectroLink landing page is available

  Scenario: Visitor understands the value proposition
    When the visitor opens the "main" section of the landing page
    Then the page describes continuous electrical monitoring
    And the page exposes a link to the web application

  Scenario: Visitor opens the web application from the main section
    Given the web application service is available
    When the visitor selects the link to the web application
    Then the web application displays the sign-in page

  Scenario: Visitor finds the web application unavailable
    Given the web application service is unavailable
    When the visitor selects the link to the web application
    Then the page displays the message "Service unavailable. Please try again."
    And the page offers a retry option

  Scenario Outline: Value proposition is served in every published language
    When the visitor opens the "main" section of the landing page in "<language>"
    Then the value proposition is displayed in "<language>"
    And the page exposes a link to the web application

    Examples:
      | language |
      | English  |
      | Spanish  |
