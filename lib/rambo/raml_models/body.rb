require "json_test_data"

module Rambo
  module RamlModels
    class Body

      attr_reader :body, :type

      def initialize(raml)
        @body = raml
      end

      def content_type
        body.content_type
      end

      def example
        @example ||= body.example || generate_from_schema || {}.to_json
      end

      def schema
        @schema ||= body.schema
      end

      private

      def generate_from_schema
        return nil if body.schema.nil?
        JSON.pretty_generate(JsonTestData.generate!(body.schema, ruby: true))
      end
    end
  end
end
