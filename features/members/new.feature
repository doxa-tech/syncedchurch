Feature: Create a new member

  So that I can have a list of members in the church
  As an administrator
  I want to create a new member

  Background:
    Given I am authorized to manage members
    When I visit "/members/new"

  Scenario: I add a member with the required fields
    And I complete the member's form with the required fields
    Then I should see a flash containing "Le nouveau membre a été ajouté !"
    And I should see the member's information

  Scenario: I add a member without the required fields
    And I do not complete the form
    Then I should see errors for the fields "Nom, Prénom"

  @javascript
  Scenario: I add a member with phone numbers
    And I add phone numbers
    And I complete the member's form with the required fields
    Then I should see the member's phone numbers

  @javascript
  Scenario: I add a member with private phones
    And I add phone numbers
    And I mark a number as private
    When I complete the member's form with the required fields
    Then I should not see the private phone in the public list

  Scenario: I add a member with a new family
    And I add the member in a new family
    And I complete the member's form with the required fields
    Then I should see the member's family

  Scenario: I add a member with private information
    And I mark fields as private
    And I complete the member's form with the required fields
    Then I should not see the private information in the public list