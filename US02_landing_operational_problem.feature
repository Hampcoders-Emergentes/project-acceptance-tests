# language: en

@user-story @us02 @ep01 @landing
Feature: Understanding the operational problem of the sector
  As a visitor
  I want to understand the electrical safety problem in quick-service restaurant chains
  So that I can value continuous monitoring

  Background:
    Given the ElectroLink landing page is available

  Scenario: Visitor understands the operational problem
    When the visitor opens the "problem" section of the landing page
    Then the page shows electrical risk figures
    And the page shows the operational consequences for quick-service restaurants

  Scenario: Problem content cannot load
    Given the problem section content is unavailable
    When the visitor opens the "problem" section of the landing page
    Then the page displays the message "Content unavailable. Please try again."
    And the page offers a retry option

  Scenario: Visitor browses with a limited connection
    Given the visitor browses the landing page on a limited connection
    When the visitor opens the "problem" section of the landing page
    Then the page shows the essential problem content
    And the page displays a limited-connection notice
