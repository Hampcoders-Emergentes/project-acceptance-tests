# language: en

@user-story @us08 @ep02 @safety
Feature: Operational risk level per equipment
  As a store worker
  I want to know the operational risk level of each equipment
  So that I can decide how to handle it safely during the shift

  Background:
    Given the store "Lima Norte" is monitored
    And the worker "Lucia" is on shift at the "Lima Norte" store

  Scenario: Worker sees a critical risk condition
    Given the sensor of "Fryer 01" reports a leakage current of 42 mA
    When the local panel evaluates the measurement
    Then the equipment risk level is "CRITICAL"
    And the panel displays the instruction "DO NOT TOUCH"
    And the panel displays the risk level in "red"

  Scenario: Worker sees an equipment without sensor signal
    Given the sensor of "Oven 02" is not reporting signal for 10 minutes
    When the local panel evaluates the supervision status
    Then the equipment risk level is "UNSUPERVISED"
    And the panel recommends reporting the case to the store manager

  Scenario: Worker checks the risk level while the panel is offline
    Given the local panel is offline
    And the sensor of "Freezer 03" reports a leakage current of 38 mA
    When the worker checks the risk level of "Freezer 03" on the local panel
    Then the panel displays the risk level "CRITICAL" from the local signal
    And the panel queues the event for later synchronization

  Scenario Outline: Risk level derives from the measured condition
    Given the sensor of "<equipment>" reports <measurement> of <value> <unit>
    When the local panel evaluates the measurement
    Then the equipment risk level is "<risk>"
    And the panel displays the instruction "<instruction>"

    Examples:
      | equipment  | measurement       | value | unit | risk     | instruction      |
      | Fryer 01   | a leakage current | 42    | mA   | CRITICAL | DO NOT TOUCH     |
      | Oven 02    | a temperature     | 78    | °C   | WARNING  | HANDLE WITH CARE |
      | Freezer 03 | a voltage         | 219   | V    | OK       | SAFE TO USE      |
