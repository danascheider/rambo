module Rambo
  module RamlModels
    class Response
      attr_reader :status_code, :schema

      def initialize(raml)
        @status_code, @schema = raml
      end

      def bodies
        @bodies ||= schema.bodies.map {|body| Rambo::RamlModels::Body.new(body) }
      end
    end
  end
end
