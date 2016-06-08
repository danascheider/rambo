require "rake/dsl_definition"
require "yaml"

module Rambo
  module Rake
    class Task
      def initialize
        @options = yaml_options || { raml: File.expand_path("doc/raml/*.raml"), rails: true }
      end

      def yaml_options
        YAML.load(File.read(File.expand_path(".rambo.yml")))
      rescue
        nil
      end
    end
  end
end
