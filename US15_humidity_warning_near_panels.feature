# language: en

@user-story @us15 @ep02 @safety
Feature: Humidity warning near electrical panels
  As a store worker
  I want to know the humidity condition near the electrical panels
  So that I can avoid operating on a risky surface

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Ambient sensor detects excessive humidity
    Given the ambient sensor of "Panel A" reports humidity of 85 %
    When the local panel evaluates the measurement
    Then the panel warns about a wet surface near "Panel A"
    And the panel recommends not connecting equipment in the area

  Scenario: Ambient sensor does not report signal
    Given the ambient sensor of "Panel A" is not reporting signal
    When the local panel evaluates the supervision status
    Then the panel shows the ambient condition as unsupervised
    And the panel recommends operating with caution near "Panel A"

  Scenario: Humidity is detected while the panel is offline
    Given the local panel is offline
    And the ambient sensor of "Panel A" reports humidity of 92 %
    When the local panel evaluates the measurement
    Then the panel keeps the local warning active
    And the panel queues the event for later synchronization

  Scenario Outline: Humidity risk level depends on the measured value
    Given the ambient sensor of "Panel A" reports humidity of <humidity> %
    When the local panel evaluates the measurement
    Then the humidity risk level is "<level>"
    And the panel displays "<instruction>"

    Examples:
      | humidity | level    | instruction              |
      | 45       | OK       | OPERATION ALLOWED        |
      | 70       | WARNING  | AVOID WATER CONTACT      |
      | 95       | CRITICAL | DO NOT CONNECT EQUIPMENT |
