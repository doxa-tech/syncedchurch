Feature: become an user

  So that a leader can also manage the church
  As an administrator
  I want a member to become an user

  Scenario: I successfully convert a member to an user
    #Given I am logged in
    When I visit the member edit path
    And I click the link "Convertir en utilisateur"
    Then I should see a flash containing "Le membre est à présent un utilisateur !"
    And I should see the user's password and username

  Scenario: I try to convert a member without an email
    #Given I am logged in
    When I visit the edit path of a member without an email
    And I click the link "Convertir en utilisateur"
    Then I should see a flash containing "Veuillez ajouter un email au membre avant de la convertir !"

  Scenario: I successfully convert a user back to a member
    #Given I am logged in
    When I visit edit path of a member who is an user
    And I click the link "Reconvertir en membre"
    Then I should see a flash containing "L'utilisateur est à nouveau un simple membre !"