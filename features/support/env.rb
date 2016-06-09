require 'coveralls'

Coveralls.wear! if ENV["COVERAGE"] == "true"

require 'aruba/cucumber'
require_relative './cucumber_helper'

World(CucumberHelper)

CUCUMBER_DIR_ROOT = File.expand_path("../", __FILE__)
RAMBO_ROOT =  File.expand_path("../../lib", __FILE__)
