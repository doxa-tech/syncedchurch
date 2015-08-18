Feature: Create a new member

  So that I can have a list of members in the church
  As an administrator
  I want to create a new member

  @genders @phone_types
  Scenario: I add a member with the required fields
    #Given I am logged in
    When I visit "/members/new"
    And I complete the member form with the required fields
    Then I should see a flash containing "Un nouveau membre a été ajouté"
    And I should see the member's information

  Scenario: I add a member without the required fields
    #Given I am logged in
    When I visit "/members/new"
    And I do not complete the form
    Then I should see errors for the fields "Nom, Prénom, Sexe"

  @genders @phone_types @javascript
  Scenario: I add a member with phone numbers
    #Given I am logged in
    When I visit "/members/new"
    And I add phone numbers
    And I complete the member form with the required fields
    Then I should see the member phone numbers