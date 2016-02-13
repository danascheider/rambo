Feature: Error handling

  Scenario: No filename is given
    When I run `rambo`
    Then the output should contain "USAGE: rambo [FILE]"

  Scenario: File given is not a RAML file
    Given a file "foobar.yml" with:
      """
      foo: bar
      """
    When I run `rambo foobar.yml`
    Then the output should contain "Unsupported file format. Please choose a RAML file."