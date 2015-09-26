Feature: Create a new meeting

  So that I can have an overview of the meetings in the church
  As I administrator
  I want to create a new meeting

  Scenario: I create a meeting with the required fields
    #Given I am logged in
    Given there is a group
    When I visit the new meeting's page
    And I complete meeting's form with the required fields
    Then I should see a flash containing "La réunion a été enregistrée"
    And I should see the new meeting's overview

  Scenario: I create a meeting without the required fields
    #Given I am logged in
    Given there is a group
    When I visit the new meeting's page
    And I do not complete the form
    Then I should see errors for the fields "Membres présents"

  @javascript
  Scenario: I choose a group and then I create a meeting
    #Given I am logged in
    Given there is a group
    When I visit "/meetings/choose"
    And I choose a group and I continue
    Then I should see the form to create a meeting

  @javascript
  Scenario: I create a meeting with an external member
    #Given I am logged in
    Given there is a group
    And there are members in the church
    When I visit the new meeting's page
    And I select an external member
    And I complete meeting's form with the required fields
    Then I should see a flash containing "La réunion a été enregistrée"
    And I should see the meeting with the external member

  @javascript
  Scenario: I create a meeting with multiple files
    #Given I am logged in
    Given there is a group
    When I visit the new meeting's page
    And I upload multiple files
    And I complete meeting's form with the required fields
    Then I should see a flash containing "La réunion a été enregistrée"
    And I should see the files in the meeting's overview