module Rambo
  module RamlModels
    class Response
      attr_reader :status, :schema

      def initialize(raml)
        @status, @schema = raml
      end

      def status_code
        schema.status_code
      end

      def bodies
        @bodies ||= schema.bodies.map {|body| Rambo::RamlModels::Body.new(body) }
      end
    end
  end
end
