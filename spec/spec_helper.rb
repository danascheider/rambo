require "simplecov"
require "coveralls"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start if ENV["COVERAGE"]

require "rspec"
require "rspec/core"
require "rspec/matchers"
require "rspec/expectations"
require "raml-rb"
require "json_test_data"

lib   = File.expand_path("../../lib", __FILE__)

Dir.foreach("#{lib}")   {|f| require f if f.match(/.*\.rb\z/) }

require_relative "../lib/raml_models/api"
