require "json_test_data"

module Rambo
  module RamlModels
    class Body
      attr_reader :body, :example

      def initialize(body)
        @body = body
      end

      def content_type
        body.content_type
      end

      def example
        @example ||= body.example || JsonTestData.generate!(body.schema) || {}
      end
    end
  end
end
