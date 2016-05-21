require "coveralls"

Coveralls.wear! if ENV["COVERAGE"] == "true"

require "rspec"
require "rspec/core"
require "rspec/matchers"
require "rspec/expectations"
require "raml"
require "json_test_data"

lib = File.expand_path("../../lib", __FILE__)
SPEC_DIR_ROOT = File.expand_path("../", __FILE__)

Dir.foreach("#{lib}")   {|f| require f if f.match(/.*\.rb\z/) }

RSpec.configure do |c|
  c.disable_monkey_patching!
  c.order = :random
end
