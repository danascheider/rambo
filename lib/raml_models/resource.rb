module Rambo
  module RamlModels
    class Resource
      attr_reader :schema

      def initialize(raml_resource)
        @schema = raml_resource.is_a?(Array) ? raml_resource.last : raml_resource
      end

      def uri_partial
        schema.name
      end

      def http_methods
        @http_methods ||= schema.methods.map {|name, method| Rambo::RamlModels::Method.new(method) }
      end

      alias_method :to_s, :uri_partial
    end
  end
end
