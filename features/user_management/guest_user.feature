@5
Feature: Allow guest accounts
  As a first-time user
  I want to use the app without registration
  So there is no barrier and I won't loose my interest

  Background:
    Given I have 13 broadcasts in my database

  Scenario: Guests can see suggestions without being logged in
    When I visit the landing page
    And I click on "Participate now"
    Then I see the first suggestion
    But no account was created in the database

  Scenario: Responses to suggestions will be saved up account registration
    Given I responded 5 times with 'Yes' to a suggestion
    And at first, no selection and no account was created in the database
    When I click on "Sign up"
    And I fill in my email and password and confirm the password
    And I click on the submit button
    Then my login was successful
    Then my all my responses are saved in the database along with my account


