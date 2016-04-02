Feature: Modify spec helper
  Scenario: JSON and rack/test are required
    Given a file named "spec/spec_helper.rb" with:
      """
      require "rspec"
      require "rspec/core"
      require "rspec/matchers"
      require "rspec/expectations"
      require "rack/test"
      require "raml-rb"
      require "json"

      path = File.expand_path('../../lib', __FILE__)

      Dir.foreach(path) {|f| require f if f.match(/.*\.rb\z/) }
      """
    And a file named "foo.raml" with:
      """
      #%RAML 0.8
      ---
      title: e-BookMobile API
      baseUri: http://api.e-bookmobile.com/{version}
      version: v1
      """
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should contain:
      """
      require "rspec"
      require "rspec/core"
      require "rspec/matchers"
      require "rspec/expectations"
      require "rack/test"
      require "raml-rb"
      require "json"

      path = File.expand_path('../../lib', __FILE__)

      Dir.foreach(path) {|f| require f if f.match(/.*\.rb\z/) }
      """

  Scenario: Only JSON is required
    Given a file named "spec/spec_helper.rb" with:
      """
      require "rspec"
      require "rspec/core"
      require "rspec/matchers"
      require "rspec/expectations"
      require "raml-rb"
      require "json"

      path = File.expand_path('../../lib', __FILE__)

      Dir.foreach(path) {|f| require f if f.match(/.*\.rb\z/) }
      """
    And a file named "foo.raml" with:
      """
      #%RAML 0.8
      ---
      title: e-BookMobile API
      baseUri: http://api.e-bookmobile.com/{version}
      version: v1
      """
    When I run `rambo foo.raml`
    Then the file "spec/spec_helper.rb" should contain:
      """
      require "rspec"
      require "rspec/core"
      require "rspec/matchers"
      require "rspec/expectations"
      require "raml-rb"
      require "json"
      require "rack/test"

      path = File.expand_path("../../lib", __FILE__)

      Dir.foreach(path) {|f| require f if f.match(/.*\.rb\z/) }
      """
