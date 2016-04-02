Feature: Modify spec helper
  Background:
    Given a file named "foo.raml" like "basic_raml.raml"

  Scenario: JSON and rack/test are required
    Given a file named "spec/spec_helper.rb" like "good_spec_helper.rb.ex"
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should be like "good_spec_helper.rb.ex"

  Scenario: Only JSON is required
    Given a file named "spec/spec_helper.rb" like "spec_helper_only_json.rb.ex"
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should be like "spec_helper_rack_test_added.rb.ex"

  Scenario: Only rack/test is required
    Given a file named "spec/spec_helper.rb" like "spec_helper_only_rack_test.rb.ex"
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should be like "spec_helper_json_added.rb.ex"
