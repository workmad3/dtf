Feature: Verification of associations
  Background:
    Given a user

  Scenario: it should own verification suites
    When I create a verification suite
    Then I should see my verification suite

  Scenario: it should own analysis cases
    When I create a analysis case
    Then I should see my analysis case
