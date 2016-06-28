module Rambo
  module RamlModels
    class Api
      attr_reader :schema, :options

      def initialize(parsed_raml, options={})
        @schema, @options = parsed_raml, options
      end

      def resources
        @resources ||= schema.resources.map {|resource| Rambo::RamlModels::Resource.new(resource, headers) }
      end

      def title
        @title ||= schema.title
      end

      def security_schemes
        @security_schemes ||= schema.security_schemes.map {|scheme| Rambo::RamlModels::SecurityScheme.new(scheme, options) }
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
