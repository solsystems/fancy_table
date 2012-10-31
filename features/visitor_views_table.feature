Feature: Visitor views table

  Scenario: A basic fancy_table
    Given 3 episodes exist
    When I view the episodes index
    Then I should see 3 fancy rows
