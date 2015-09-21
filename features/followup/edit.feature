Feature: Edit a followup

  So that I can correct the information of a followup
  As a qualified person
  I want to edit a followup

  Scenario: I successfully edit a followup
    #Given I a logged in
    When I visit the followup edit path
    And I change the duration of the meeting
    Then I should see a flash containing "Le suivi a été mis à jour !"
    And I should see the updated duration 