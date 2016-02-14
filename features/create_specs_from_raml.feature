Feature: Create tests from RAML

  Scenario: Generate specs from a simple RAML file
    Given a file named "foo.raml" with:
      """
      #%RAML 0.8
      ---
      title: e-BookMobile API
      baseUri: http://api.e-bookmobile.com/{version}
      version: v1
      """
    When I run `rambo foo.raml`
    Then the directory "spec/contract" should exist
    And the file "spec/contract/foo_spec.rb" should exist
    And the file "spec/spec_helper.rb" should exist
    And the file "spec/contract/foo_spec.rb" should contain:
      """
      require 'spec_helper'
      """
    And the exit status should be 0