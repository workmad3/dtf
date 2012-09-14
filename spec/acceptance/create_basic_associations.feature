Feature: Verification of User associations
  Background:
    Given a User

  Scenario: User should own Verification Suites
    When I create a Verification Suite
    Then I should own a Verification Suite

  Scenario: User should own Analysis Cases
    When I create an Analysis Case
    Then I should own an Analysis Case
