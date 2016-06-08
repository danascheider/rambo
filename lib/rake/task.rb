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
        {}
      end
    end
  end
end
