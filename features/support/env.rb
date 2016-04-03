require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter

if ENV['COVERAGE']
  SimpleCov.start do
    add_filter 'app/secrets'
  end
end

require 'aruba/cucumber'
require_relative './cucumber_helper'

World(CucumberHelper)
