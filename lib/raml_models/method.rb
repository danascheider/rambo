module Rambo
  module RamlModels
    class Method
      attr_reader :schema

      def initialize(raml_method)
        @schema = raml_method
      end

      def to_s
        schema.method.upcase
      end

      def responses
        @responses ||= schema.responses.map {|resp| Response.new(resp) }
      end

      alias_method :method, :to_s
    end
  end
end
