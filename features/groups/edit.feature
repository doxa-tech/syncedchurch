Feature: Edit a group

  So that a group is up-to-date
  As an administrator
  I want to update a group

  @javascript
  Scenario: I update the ground information
    #Given I am logged in
    When I visit the edit page of a group
    And I change the name of the group with "Conseil exécutif"
    Then I should see a flash containing "Mis à jour !"
    And I should see the updated name of the group

  @javascript @wip
  Scenario: I update with an invalid information
    #Given I am logged in
    When I visit the edit page of a group
    And I change the name of the group with ""
    Then I should see errors for the fields "Nom"