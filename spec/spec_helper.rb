require "coveralls"

Coveralls.wear! if ENV["COVERAGE"] == "true"

require "rspec"
require "rspec/core"
require "rspec/matchers"
require "rspec/expectations"
require "raml-rb"
require "json_test_data"
require "fileutils"

SPEC_DIR_ROOT = File.expand_path("../", __FILE__)
RAMBO_ROOT =  File.expand_path("../../lib", __FILE__)
lib = File.expand_path(File.join(RAMBO_ROOT, "**/*.rb"))
Dir[lib].each {|f| require f }

RSpec.configure do |c|
  c.disable_monkey_patching!
  c.order = :random

  c.after(:each) do
    File.delete("spec/rambo_helper.rb") rescue nil
    FileUtils.rm_rf("spec/support/matchers") rescue nil
  end
end
