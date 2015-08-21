Feature: Create a new group

  So that I can represent the groups in the church
  As an administrator
  I want to create a new group

  Scenario: I add a group with the required fields
    #Given I am logged in
    When I visit "/groups/new"
    And I complete group's form with the required fields
    Then I should see a flash containing "Le nouveau groupe a été créé !"
    And I should see the group's information

  Scenario: I add a group without the required fields
    #Given I am logged in
    When I visit "/groups/new"
    And I do not complete the group's form
    Then I should see errors for the fields "Nom"