require "coveralls"

Coveralls.wear! if ENV["COVERAGE"] == "true"

require "rspec"
require "rspec/core"
require "rspec/matchers"
require "rspec/expectations"
require "raml-rb"
require "json_test_data"

lib   = File.expand_path("../../lib", __FILE__)

Dir.foreach("#{lib}")   {|f| require f if f.match(/.*\.rb\z/) }

require_relative "../lib/raml_models/api"
require_relative "../lib/raml_models/resource"
require_relative "../lib/raml_models/method"
require_relative "../lib/raml_models/response"
