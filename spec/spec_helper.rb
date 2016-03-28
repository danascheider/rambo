require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start if ENV['COVERAGE']

require 'rspec'
require 'rspec/core'
require 'rspec/matchers'
require 'rspec/expectations'
require 'raml-rb'
require 'json'

require_relative '../lib/cli'
require_relative '../lib/document_generator'
require_relative '../lib/rspec/spec_file'
require_relative '../lib/rspec/examples'
require_relative '../lib/rspec/example_group'
