module Rambo
  module RamlModels
    class Method
      attr_reader :schema

      def initialize(raml_method)
        @schema = raml_method
      end

      def to_s
        schema.method
      end

      def request_body
        Rambo::RamlModels::Body.new(schema.bodies.first) if schema.bodies.first
      end

      def description
        @description ||= schema.description
      end

      def responses
        @responses ||= schema.responses.map {|resp| Rambo::RamlModels::Response.new(resp) }
      end

      alias_method :method, :to_s
    end
  end
end
