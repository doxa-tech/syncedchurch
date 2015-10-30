Feature: Edit his password

  So that I can change the default password
  As a user
  I want to update my password

  @wip
  Scenario: I successfully update my password
    #Given I am logged in
    When I visit "/user/password/edit"
    And I complete the form with a new password
    Then I should see a flash containing "Mot de passe mis à jour"
    And I should be able to log in with my new password