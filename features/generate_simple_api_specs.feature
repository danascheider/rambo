Feature: Generate simple API specs

  Scenario: Route with example
    Given a file named "foo.raml" like "basic_raml_with_example.raml"
    When I run `rambo foo.raml`
    Then the file "spec/contract/foo_spec.rb" should be like "simple_spec_file_with_example.rb.example"

  Scenario: Route with schema
    Given a file named "foo.raml" like "basic_raml_with_schema.raml"
    When I run `rambo foo.raml`
    Then the file "spec/contract/foo_spec.rb" should be like "simple_spec_file_with_schema.rb.example"
