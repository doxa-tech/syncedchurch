Feature: Follow up a member

  So that I can follow up a member
  As a qualified person
  I want to add a new meeting

  @javascript
  Scenario: I add a new meeting
    #Given I am logged in
    Given there are members in the church
    When I visit "/followups/new"
    And I complete meeting's form with the required fields
    Then I should see a flash containing "La rencontre a été enregistrée"