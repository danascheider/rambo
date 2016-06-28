module Rambo
  module RamlModels
    class SecurityScheme
      attr_accessor :schema, :title
      private :schema

      def initialize(raml)
        @schema, @title = raml.last.fetch("described_by", {}), raml.first
      end

      def headers
    end
  end
end
