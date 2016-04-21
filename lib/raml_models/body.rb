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
          body.example
        elsif body.schema
          JSON.parse(JsonTestData.generate!(body.schema), symbolize_names: true)
        else
          {}.to_json
        end
      end
    end
  end
end
