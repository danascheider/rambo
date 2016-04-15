module Rambo
  module RamlModels
    class Resource
      attr_reader :schema

      def initialize(raml_resource)
        @schema = raml_resource
      end

      def to_s
        schema.uri_partial
      end
    end
  end
end
