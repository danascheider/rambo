require "fileutils"
require "raml_parser"

require File.expand_path("../rspec/spec_file.rb", __FILE__)
require File.expand_path("../rspec/spec_helper_file.rb", __FILE__)

module Rambo
  class DocumentGenerator
    attr_accessor :file, :raml

    def initialize(file)
      @file = file
      @raml = RamlParser::Parser.parse_file(file)
    end

    def generate_spec_dir!
      FileUtils.mkdir_p("spec/contract")
    end

    def generate_spec_file!
      spec_file_name = file.match(/[^\/]*\.raml$/).to_s.gsub(/\.raml$/, "_spec.rb")
      contents       = Rambo::RSpec::SpecFile.new(raml).render
      File.open("spec/contract/#{spec_file_name}", "w+") do |f|
        f.puts contents
      end
    end

    def generate_rambo_helper!
      Rambo::RSpec::SpecHelperFile.new.generate
    end
  end
end
