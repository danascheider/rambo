require 'coveralls'

Coveralls.wear! if ENV["COVERAGE"] == "true"

require 'aruba/cucumber'
require_relative './cucumber_helper'

World(CucumberHelper)
