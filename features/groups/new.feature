Feature: Create a new group

  So that I can represent the groups in the church
  As an administrator
  I want to create a new group

  Background:
    Given I am authorized to manage groups
    When I visit "/groups/new"

  Scenario: I add a group with the required fields
    And I complete group's form with the required fields
    Then I should see a flash containing "Le nouveau groupe a été créé !"
    And I should see the group's information

  Scenario: I add a group without the required fields
    And I do not complete the group's form
    Then I should see errors for the fields "Nom"