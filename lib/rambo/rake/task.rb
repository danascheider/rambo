lib = File.expand_path("../../..", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "rake"
require "yaml"
require "colorize"
require "rambo/document_generator"

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
          Rambo::DocumentGenerator.generate!(raml_file)

          puts "Done generating contract tests.".green
        end
      end

      # TODO: Permit use of multiple RAML files, since right now this only takes
      #       the first one it finds in the "doc" directory.

      def raml_file
        return options.fetch("raml") if options.fetch("raml", nil)
        Dir.foreach("doc/raml") {|file| return "doc/raml/#{file}" if file.match(/\.raml$/) }
      end
    end
  end
end
