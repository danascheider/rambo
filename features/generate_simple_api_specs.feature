Feature: Generate simple API specs

  Scenario: Single resource route
    Given a file named "foo.raml" like "basic_raml.raml"
    When I run `rambo foo.raml`
    Then the file "spec/contract/foo_spec.rb" should be like "simple_spec_file.rb.ex"
