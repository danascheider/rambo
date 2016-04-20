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

      def to_s
        schema.method.upcase
      end
    end
  end
end
