@54
Feature: Reselect broadcast
  As a user
  I want to have a list with all my deselected broadcasts and an option to re-select some of them
  Because I changed my mind and want to add them to my invoice again

  Background:
    Given I am logged in

  Scenario: Show the history of my actions
    Given yesterday I deselected a broadcast called "Kontraste"
    But there is another broadcast called "Aspekte" which I don't know yet
    When I visit my history page
    Then I see "Kontraste", because it's reviewed, but I don't see "Aspekte"

  Scenario: Reselect a previously neglected broadcast
    Given yesterday I deselected a broadcast called "Kontraste"
    And today I learned that it is actually a broadcast that I really like
    When I visit my history page
    And I click on the unimpressed smiley next to "Kontraste"
    Then the smiley turns happy
    And on my invoice, this broadcast shows up suddenly

