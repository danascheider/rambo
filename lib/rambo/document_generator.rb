require "fileutils"
require "raml-rb"

require "rambo/rspec/spec_file"
require "rambo/rspec/helper_file"

module Rambo
  class DocumentGenerator
    attr_accessor :file, :raml, :options

    class << self
      def generate!(file, options={})
        generator = new(file, options)
        generator.generate_spec_dir!
        generator.generate_rambo_helper!
        generator.generate_matcher_dir!
        generator.generate_matchers!
        generator.generate_examples!
      end
    end

    def initialize(file, options={})
      @file    = file
      @raml    = Raml::Parser.parse_file(file)
      @options = options
    end

    def generate_spec_dir!
      FileUtils.mkdir_p("spec/contract/output")
    end

    def generate_examples!
      FileUtils.mkdir_p("spec/support/examples")
    end

    def generate_spec_file!
      spec_file_name = file.match(/[^\/]*\.raml$/).to_s.gsub(/\.raml$/, "_spec.rb")
      contents       = Rambo::RSpec::SpecFile.new(raml, options).render
      File.write("spec/contract/#{spec_file_name}", contents)
    end

    def generate_rambo_helper!
      Rambo::RSpec::HelperFile.new(
        template_path: File.expand_path("../rspec/templates/rambo_helper_file_template.erb", __FILE__),
        file_path: "spec/rambo_helper.rb"
      ).generate
    end

    def generate_matcher_dir!
      FileUtils.mkdir_p("spec/support/matchers")
    end

    def generate_matchers!
      Rambo::RSpec::HelperFile.new(
        template_path: File.expand_path("../rspec/templates/matcher_file_template.erb", __FILE__),
        file_path: "spec/support/matchers/rambo_matchers.rb"
      ).generate
    end
  end
end
