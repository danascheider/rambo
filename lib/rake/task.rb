require "rake/dsl_definition"
require "yaml"
require "colorize"

module Rambo
  module Rake
    class Task
      include ::Rake::DSL

      attr_reader :options

      def initialize
        @options = yaml_options
        define_task
      end

      def yaml_options
        opts = YAML.load(File.read(File.expand_path(".rambo.yml")))

        if opts.fetch("raml", nil)
          opts["raml"] = File.expand_path(opts.fetch("raml"))
        end

        opts
      rescue
        { "rails" => true }
      end

      private

      def define_task
        desc "Generate contract tests"
        task :rambo do
          generator = Rambo::DocumentGenerator.new(raml_file)
          generator.generate_spec_dir!
          generator.generate_rambo_helper!
          generator.generate_matcher_dir!
          generator.generate_examples!
          generator.generate_matchers!

          puts "Done generating contract tests.".green
        end
      end

      def raml_file
        return options.fetch("raml") if options.fetch("raml", nil)
        Dir.foreach("doc/raml") {|file| return file if file.match(/\.raml$/) }
      end
    end
  end
end
