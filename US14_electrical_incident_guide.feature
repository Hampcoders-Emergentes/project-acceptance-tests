# language: en

@user-story @us14 @ep02 @safety
Feature: Electrical incident action guide
  As a store worker
  I want to know the action guide for an electrical incident
  So that I can support an affected colleague safely

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Worker consults the action guide during an incident
    Given an electrical incident occurs in the kitchen
    When the worker opens the incident action guide
    Then the guide shows the isolation instructions
    And the guide shows the immediate rescue instructions

  Scenario: Worker consults the action guide while the panel is offline
    Given the local panel is offline
    And the incident action guide is stored locally
    When the worker opens the incident action guide
    Then the panel returns the guide from local storage

  Scenario: Action guide is not available for the store
    Given the incident action guide is not available for the "Lima Norte" store
    When the worker opens the incident action guide
    Then the panel indicates that direct intervention is not allowed
    And the panel recommends notifying the store manager

  Scenario Outline: First instruction depends on the incident type
    Given an electrical incident of type "<incident>" occurs in the kitchen
    When the worker opens the incident action guide
    Then the first guide instruction is "<instruction>"

    Examples:
      | incident           | instruction                    |
      | electric shock     | ISOLATE THE POWER SOURCE       |
      | equipment fire     | USE THE EMERGENCY EXTINGUISHER |
      | water contact      | DO NOT TOUCH THE EQUIPMENT     |
