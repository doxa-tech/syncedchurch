Feature: Follow up a member

  So that I can follow up a member
  As a qualified person
  I want to add a new meeting

  Background:
    Given I am authorized to manage followups

  @javascript
  Scenario: I add a new meeting with the required fields
    Given there are members in the church
    And I am authorized to manage members
    When I visit "/followups/new"
    And I complete followup's form with the required fields
    Then I should see a flash containing "La rencontre a été enregistrée"
    And I should see the new followup's overview

  Scenario: I add a followup without the required fields
    When I visit "/followups/new"
    And I do not complete the form
    Then I should see errors for the fields "Membre, Conseiller, Durée"