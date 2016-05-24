require "fileutils"
require "raml-rb"

require "rspec/spec_file"
require "rspec/rambo_helper_file"
require "rspec/matcher_file"

module Rambo
  class DocumentGenerator
    attr_accessor :file, :raml

    def initialize(file)
      @file = file
      @raml = Raml::Parser.parse_file(file)
    end

    def generate_spec_dir!
      FileUtils.mkdir_p("spec/contract")
    end

    def generate_examples!
      FileUtils.mkdir_p("spec/support/examples")
    end

    def generate_spec_file!
      spec_file_name = file.match(/[^\/]*\.raml$/).to_s.gsub(/\.raml$/, "_spec.rb")
      contents       = Rambo::RSpec::SpecFile.new(raml).render
      File.open("spec/contract/#{spec_file_name}", "w+") do |f|
        f.puts contents
      end
    end

    def generate_rambo_helper!
      Rambo::RSpec::RamboHelperFile.new.generate
    end

    def generate_matcher_dir!
      FileUtils.mkdir_p("spec/support/matchers")
    end

    def generate_matchers!
      Rambo::RSpec::MatcherFile.new.generate
    end
  end
end
