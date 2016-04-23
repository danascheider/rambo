require "json_test_data"

module Rambo
  module RamlModels
    class Body
      attr_reader :body

      def initialize(body)
        @body = body
      end

      def content_type
        body.content_type
      end

      def example
        if body.example
          eval(body.example)
        elsif body.schema
          JsonTestData.generate!(body.schema, ruby: true)
        else
          {}
        end
      end
    end
  end
end
