module Rambo
  module RamlModels
    class Method
      attr_reader :schema

      def initialize(raml_method)
        @schema = raml_method
      end

      def method
        schema.method
      end

      def request_body
        Rambo::RamlModels::Body.new(request_body_from_schema) if has_request_body?
      end

      def description
        @description ||= schema.description
      end

      def responses
        @responses ||= schema.responses.map {|resp| Rambo::RamlModels::Response.new(resp) }
      end

      private

      def has_request_body?
        schema.bodies.first != nil
      end

      def request_body_from_schema
        return unless schema.bodies.first
        schema.bodies.first.example || JSON.pretty_generate(JsonTestData.generate!(schema.bodies.first.schema, ruby: true))
      end
    end
  end
end
