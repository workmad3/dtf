Feature: Basic Model(s) Creation
  Background:
    Given a user
    And a verification suite

  Scenario: Fundamental Models instantiate
    When I view the verification suite contents
    Then I should see user ownership
    And I should see analysis cases
    And I should see case tests

  Scenario: User Model's world created
    Then I should be a user
    Then I should see VS ownerships
    Then I should see AC ownerships
    Then I should see CT ownerships
