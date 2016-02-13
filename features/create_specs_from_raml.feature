Feature: Create tests from RAML

  Scenario: Simple RAML file
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