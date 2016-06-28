module Rambo
  module RamlModels
    class Api
      attr_reader :schema

      def initialize(parsed_raml)
        @schema = parsed_raml
      end

      def resources
        @resources ||= schema.resources.map {|resource| Rambo::RamlModels::Resource.new(resource, headers) }
      end

      def title
        @title ||= schema.title
      end

      def security_schemes
        @security_schemes = schema.security_schemes
      end

      def headers
        @headers ||= {}

        if schema.media_type
          @headers.merge({ "Content-Type" => schema.media_type })
        end

        @headers
      end
    end
  end
end
