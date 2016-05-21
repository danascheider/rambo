module Rambo
  module RamlModels
    class Resource
      attr_reader :schema

      def initialize(raml_resource)
        @schema = raml_resource
      end

      def http_methods
        @http_methods ||= schema.methods.map {|method| Rambo::RamlModels::Method.new(method) }
      end

      def to_s
        schema.relative_uri
      end

      alias_method :uri_partial, :to_s
    end
  end
end
