module Rambo
  module RamlModels
    class Method
      attr_reader :schema

      def initialize(raml_method)
        @schema = raml_method
      end

      def method
        schema.name
      end

      def request_body
        Rambo::RamlModels::Body.new(request_body_from_schema) if request_body_from_schema
      end

      def description
        @description ||= schema.description
      end

      def responses
        @responses ||= schema.children.map {|resp| Rambo::RamlModels::Response.new(resp) }
      end

      private

      def request_body_from_schema
        schema.children.first.children.first
      end
    end
  end
end
