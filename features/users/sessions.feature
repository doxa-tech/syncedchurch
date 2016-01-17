Feature: Log in & out

  So that I can access the functionalities
  As a visitor
  I want to log in & out

  Background:
    Given there is an user

  Scenario: I successfully login
    When I visit "/login"
    And I complete the form with "bruce@wayne.com" and "12341"
    Then I should see a flash containing "Vous êtes à présent connecté !"
    And I should see my name in the topbar

  Scenario: I try to login with the wrong information
    When I visit "/login"
    And I complete the form with "bruce@wayne.com" and "i am a wrong password"
    Then I should see a flash containing "Nom d'utilisateur et/ou mot de passe incorrect"
    And I should not be logged in

  Scenario: I logout
    When I login
    And I click the link "Se déconnecter"
    Then I should see a flash containing "Vous êtes déconnecté !"
    And I should not be logged in
