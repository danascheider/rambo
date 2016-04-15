module Rambo
  module RamlModels
    class Api
      attr_reader :schema, :resources

      def initialize(raml)
        @schema = raml
      end

      def resources
        @resources ||= schema.resources
      end
    end
  end
end
