Feature: Edit a group

  So that a group is up-to-date
  As an administrator
  I want to update a group

  Background:
    Given I am authorized to manage groups
    Given there is a group

  @javascript
  Scenario: I update the ground information
    When I visit the edit page of the group
    And I change the name of the group with "Conseil exécutif"
    Then I should see a flash containing "Mis à jour !"
    And I should see the updated name of the group

  @javascript
  Scenario: I update with an invalid information
    When I visit the edit page of the group
    And I change the name of the group with ""
    Then I should see errors for the fields "Nom"

  Scenario: I want to see the members of a group
    When I visit the edit page of the group
    Then I should see the member "Alfred Dupont" in the list

  @javascript
  Scenario: I add a member to the group
    Given I am authorized to access the add action
    And I am authorized to manage members
    And there are members in the church
    When I visit the edit page of the group
    And I choose a member and add him
    Then I should see the responsable "John Smith" in the list

  @javascript
  Scenario: I delete a member of the group
    Given I am authorized to access the remove action
    When I visit the edit page of the group
    And I click the button to delete a member of the group
    Then the member should not be anymore in the group

  @javascript
  Scenario: I change the status of a member of the group
    Given I am authorized to access the toggle action
    When I visit the edit page of the group
    And I click the button to toggle the status of a member
    Then the status of the member should have changed