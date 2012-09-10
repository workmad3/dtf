Feature: Display DTF help system to users upon request
  Background:
    Given I have dtf installed  
    
    Scenario: User should be able to request DTF command-specific help
      Given I request help on all available sub commands:
        |       cmd         |       cmd_output          |
        |   create_user     |   --email                 |
        |   delete_user     |   --delete-all            |
        |   create_vs       |   associate this VS       |
        |   delete_vs       |   ID of VS to be deleted  |

      Then I should receive each command's specific details
