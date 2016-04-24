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
        @bodies ||= schema.bodies.map {|body| Rambo::RamlModels::Body.new(body) }
      end
    end
  end
end
