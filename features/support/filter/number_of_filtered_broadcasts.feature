Feature: See number of filtered broadcasts
  As a fee payer
  I want to see how many broadcasts remain when I choose filter options
  In order to estimate how many broadcasts might be relevant to me

  Scenario: See number of unfiltered broadcasts
  Given I have these broadcasts in my database:
    | Name        | Topic     |
    | Quarks & Co | Education |
  When I visit the filter page
  Then I can read we have '3 broadcasts in total'

