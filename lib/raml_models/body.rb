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
        body.example
      end
    end
  end
end
