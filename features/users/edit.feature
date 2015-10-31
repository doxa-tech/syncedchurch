Feature: Edit his password

  So that I can change the default password
  As a user
  I want to update my password

  Background:
    Given I am logged in

  Scenario: I successfully update my password
    When I visit "/user/password/edit"
    And I complete the form with a new password
    Then I should see a flash containing "Mot de passe mis à jour"
    And I should be able to log in with my new password

  Scenario: I try to update update my password without the current one
    When I visit "/user/password/edit"
    And I complete the form without the current password
    Then I should see errors for the fields "Mot de passe actuel"

  Scenario: I must change my password the first time I login
    When I visit "/dashboard"
    And I complete the form with a new password
    When I visit "/dashboard"
    Then I should be visiting "/dashboard"