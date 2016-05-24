module Rambo
  module RamlModels
    class Resource

      FIXTURES_DIRECTORY = File.expand_path("spec/support/examples")

      attr_reader :schema

      def initialize(raml_resource)
        @schema = raml_resource
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
