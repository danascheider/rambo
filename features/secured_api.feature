Feature: Secured API

  Scenario: With auth headers
    Given a file named "foo.raml" like "secured_api.raml"
    And a file named ".rambo.yml" like "secured_rambo_yaml_file.yml"
    When I run `rambo foo.raml`
    Then the file "spec/contract/foo_spec.rb" should be like "secured_api_spec.rb.example"
