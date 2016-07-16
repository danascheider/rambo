require "active_support/core_ext/string/inflections"

module Rambo
  module RamlModels
    class Resource

      attr_reader :schema, :headers
      private :headers, :schema

      def initialize(raml_resource, headers=Rambo::RamlModels::Headers.new({}))
        @schema  = raml_resource
        @headers = headers
      end

      def uri_partial
        schema.uri_partial
      end

      alias_method :to_s, :uri_partial

      def http_methods
        @http_methods ||= schema.http_methods.map {|method| Rambo::RamlModels::Method.new(method, headers) }
      end

      def factory_name
        ":#{uri_partial[1..-1].singularize}"
      end
    end
  end
end
