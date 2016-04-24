module Rambo
  module RamlModels
    class Resource
      attr_reader :schema, :resources

      def initialize(raml_resource)
        @schema    = raml_resource
        @resources = schema.resources.map {|resource| Rambo::RamlModels::Resource.new(resource) }
      end

      def http_methods
        @http_methods ||= schema.methods.map {|method| Rambo::RamlModels::Method.new(method) }
      end

      def uri_partial
        @uri_partial ||= schema.uri_partial
      end

      def description
        @description ||= schema.description
      end

      def to_s
        schema.uri_partial
      end
    end
  end
end
