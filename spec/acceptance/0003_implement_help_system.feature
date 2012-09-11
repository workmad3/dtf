Feature: DTF Help System is correctly implemented
  Background:
    Given I have dtf installed  
    
    Scenario Outline: Sub-command specific help is received
		Given I request help for sub-command <sub_cmd>
		Then I should see <help_response> in the response

		Examples:
		| sub_cmd     | help_response |
        | create_user | --email       |
        | delete_user | --delete-all  |
        | create_vs   | --name        |
        | delete_vs   | --id          |