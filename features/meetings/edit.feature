Feature: Edit a meeting

  So that I can correct information or add files
  As a administrator
  I want to edit a meeting

  Scenario: I successfully edit a meeting
    #Given I a logged in
    When I visit the meeting edit path
    And I change the date of the meeting
    Then I should see a flash containing "Réunion mise à jour !"
    And I should see the meeting's updated date 