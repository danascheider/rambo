require "rake/dsl_definition"
require "yaml"

module Rambo
  module Rake
    class Task
      attr_reader :options

      def initialize
        @options = yaml_options
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

      def raml_file
        return options.fetch("raml") if options.fetch("raml", nil)
        Dir.foreach("doc/raml") {|file| return file if file.match(/\.raml$/) }
      end
    end
  end
end
