require "rspec"
require "rspec/core"
require "rspec/matchers"
require "rspec/expectations"
require "raml-rb"
require "json"
require "rack/test"

path = File.expand_path('../../lib', __FILE__)

Dir.foreach(path) {|f| require f if f.match(/.*\.rb\z/) }
