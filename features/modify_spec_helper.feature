Feature: Modify spec helper

  Background:
    Given a file named "foo.raml" like "basic_raml_with_example.raml"

  Scenario: JSON and rack/test are required
    Given a spec_helper.rb file that requires both JSON and rack/test
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should be like "good_spec_helper.rb.example"

  Scenario: Only JSON is required
    Given a spec_helper.rb file that requires JSON but not rack/test
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should require "rack/test"

  Scenario: Only rack/test is required
    Given a spec_helper.rb file that requires rack/test but not JSON
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should require "json"
