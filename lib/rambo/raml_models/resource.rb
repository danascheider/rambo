module Rambo
  module RamlModels
    class Resource

      attr_reader :schema, :headers
      private :headers

      def initialize(raml_resource, headers={})
        @schema  = raml_resource
        @headers = Rambo::RamlModels::Headers.new(headers)
      end

      def uri_partial
        schema.uri_partial
      end

      alias_method :to_s, :uri_partial

      def http_methods
        @http_methods ||= schema.methods.map {|method| Rambo::RamlModels::Method.new(method) }
      end
    end
  end
end
