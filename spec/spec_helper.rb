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

path = File.expand_path("../../lib", __FILE__)

Dir.foreach(path) {|f| require f if f.match(/.*\.rb\z/) }

require_relative "../lib/rspec/spec_helper_file"
