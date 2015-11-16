Feature: Create an event

  So that I have an up-to-date agenda
  As an administrator
  I want to create an new event

  Background:
    Given I am authorized to manage events

  Scenario: I add a new event with the required fields
    When I visit "/events/new"
    And I complete the event's form with the required fields
    Then I should see a flash containing "L'événement a été ajouté à l'agenda"
    And I should see the event's overview

  Scenario: I add a new event without the required fields
    When I visit "/events/new"
    And I do not complete the form
    Then I should see errors for the fields "Description"