Feature: Error handling

  @spawn
  Scenario: No filename is given
    When I run `rambo`
    Then the output should contain "USAGE: rambo [FILE]"