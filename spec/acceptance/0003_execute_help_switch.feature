Feature: Display DTF help system to users upon request
  Background:
    Given I have dtf installed

    Scenario: User should be able to request DTF command-specific help overview
      When I type "dtf --help"
      Then I should see help system output
