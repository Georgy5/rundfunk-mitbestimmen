Feature:

  Background:
    Given we have these stations in our database:
      | Station       | Medium |
      | Phoenix       | TV     |
      | ZDF           | TV     |
      | WDR Fernsehen | TV     |
    And we have these broadcasts in our database:
      | Title               | Station       | Medium |
      | Phoenix Runde       | Phoenix       | TV     |
      | Fernsehgarten       | ZDF           | TV     |
      | heute-journal       | ZDF           | TV     |
      | Quarks & Co         | WDR Fernsehen | TV     |
      | Mitternachtsspitzen | WDR Fernsehen | TV     |
      | Rockpalast          | WDR Fernsehen | TV     |
    And I visit the find broadcasts page

  Scenario: Dropdown menu ordered by name and number of broadcasts visible
    When I filter by medium "TV"
    Then the drop down menu has excactly these items:
      | Label             |
      | Phoenix (1)       |
      | WDR Fernsehen (3) |
      | ZDF (2)           |

