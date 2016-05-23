require "coveralls"

Coveralls.wear! if ENV["COVERAGE"] == "true"

require "rspec"
require "rspec/core"
require "rspec/matchers"
require "rspec/expectations"
require "raml-rb"
require "json_test_data"
require "fileutils"

lib = File.expand_path("../../lib", __FILE__)
SPEC_DIR_ROOT = File.expand_path("../", __FILE__)

Dir.foreach("#{lib}")   {|f| require f if f.match(/.*\.rb\z/) }

RSpec.configure do |c|
  c.disable_monkey_patching!
  c.order = :random

  c.after(:each) do
    File.delete("spec/rambo_helper.rb") rescue nil
    FileUtils.rm_rf("spec/support/matchers") rescue nil
  end
end
