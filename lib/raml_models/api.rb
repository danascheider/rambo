module Rambo
  module RamlModels
    class Api
      attr_reader :schema

      def initialize(parsed_raml)
        @schema = parsed_raml
      end

      def resources
        @resources ||= schema.resources.map {|uri, resource| Rambo::RamlModels::Resource.new(resource) }
      end

      def title
        @title ||= schema.title
      end
    end
  end
end
