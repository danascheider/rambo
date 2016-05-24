# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "version"

Gem::Specification.new do |s|
  s.name        = "rambo"
  s.version     = Rambo.version
  s.authors     = ["Dana Scheider"]
  s.description = "RAML in, RSpec out"
  s.summary     = "rambo-#{s.version}"
  s.email       = "dana.scheider@gmail.com"
  s.license     = "MIT"
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = ">= 2.1.0"

  s.add_dependency "rspec", "~> 3.4"
  s.add_dependency "raml-rb", "~> 0.0.6"
  s.add_dependency "rack-test", "~> 0.6"
  s.add_dependency "colorize", "~> 0.7"
  s.add_dependency "json_test_data", "~> 0.9"
  s.add_dependency "json-schema", "~> 2.6"

  s.add_development_dependency "cucumber", "~> 2.1"
  s.add_development_dependency "json", "~> 1.7"
  s.add_development_dependency "rake", "~> 11.0"
  s.add_development_dependency "coveralls", "~> 0.7"
  s.add_development_dependency "aruba", "~> 0.13"

  s.executables        = "rambo"
  s.default_executable = "rambo"

  s.rubygems_version   = ">= 1.6.1"
  s.files              = `git ls-files`.split("\n").reject {|path| path =~ /\.gitignore$/ }
  s.test_files         = `git ls-files -- {spec,features}/*`.split("\n")
  s.rdoc_options       = ["--charset=UTF-8"]
  s.require_path       = "lib"
end
