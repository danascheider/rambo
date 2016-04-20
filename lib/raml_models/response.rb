module Rambo
  module RamlModels
    class Response
      attr_reader :schema

      def initialize(raml)
        @schema = raml
      end

      def status_code
        schema.code
      end

      def bodies
        schema.bodies
      end
    end
  end
end
