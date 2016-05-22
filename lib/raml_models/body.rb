require "json_test_data"

module Rambo
  module RamlModels
    class Body
      attr_reader :body

      def initialize(raml)
        @body = raml
      end

      def content_type
        body.content_type
      end

      def example
        @example ||= body.example || generate_from_schema || {}.to_json
      end

      private

      def generate_from_schema
        return nil unless body.schema
        JSON.pretty_generate(JsonTestData.generate!(body.schema, ruby: true))
      end
    end
  end
end
