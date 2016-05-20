Feature: Generate POST specs
  Scenario: Simple POST route
    Given a file named "foo.raml" like "basic_raml_with_post_route.raml"
    When I run `rambo foo.raml`
    Then the file "spec/contract/foo_spec.rb" should be like "simple_spec_file_with_post_route.rb.example"
