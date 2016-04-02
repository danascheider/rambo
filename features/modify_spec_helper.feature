Feature: Modify spec helper
  Background:
    Given a file named "foo.raml" like "basic_raml.raml"

  Scenario: JSON and rack/test are required
    Given a spec_helper.rb file that requires both JSON and rack/test
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should be like "good_spec_helper.rb.ex"

  Scenario: Only JSON is required
    Given a spec_helper.rb file that requires JSON but not rack/test
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should be like "spec_helper_rack_test_added.rb.ex"

  Scenario: Only rack/test is required
    Given a spec_helper.rb file that requires rack/test but not JSON
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should be like "spec_helper_json_added.rb.ex"
