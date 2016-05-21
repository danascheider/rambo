module Rambo
  module RamlModels
    class Resource
      attr_reader :uri_partial, :schema

      def initialize(raml_resource)
        @uri_partial, @schema = raml_resource
      end

      def http_methods
        @http_methods ||= schema.methods.map {|method| Rambo::RamlModels::Method.new(method) }
      end

      alias_method :to_s, :uri_partial
    end
  end
end
