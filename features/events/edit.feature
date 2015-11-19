Feature: Edit an event 

  So that I can correct the event's information
  As an administrator
  I want to update an event

  Scenario: I successfully edit an event
    Given I am authorized to manage events
    When I visit the event edit path
    And I change the description of the event
    Then I should see a flash containing "L'événement a été mis à jour"
    And I should see the updated description 