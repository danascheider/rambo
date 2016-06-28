module Rambo
  module RamlModels
    class Method
      attr_reader :schema

      def initialize(raml_method, headers=Headers.new({}))
        @schema  = raml_method
        @headers = headers
      end

      def method
        schema.method
      end

      def request_body
        Rambo::RamlModels::Body.new(schema.bodies.first) if has_request_body?
      end

      def description
        @description ||= schema.description
      end

      def headers
        @headers.add(schema.headers) if schema.headers
      end

      def responses
        @responses ||= schema.responses.map {|resp| Rambo::RamlModels::Response.new(resp) }
      end

      private

      def has_request_body?
        !!schema.bodies.first
      end
    end
  end
end
