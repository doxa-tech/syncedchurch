Feature: Edit a member

  So that I can keep the member's information up-to-date
  As an administrator
  I want to update a member

  Scenario: I successfully edit a member
    #Given I a logged in
    When I visit the member edit path
    And I change the firstname of the member
    Then I should see a flash containing "Le membre a été mis à jour !"
    And I should see the updated firstname 