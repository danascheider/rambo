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
        @headers ||= Rambo::RamlModels::Headers.new({})

        add_content_type_header!(@headers)
        add_security_headers!(@headers)

        @headers
      end

      private

      def add_content_type_header!(h)
        h.add({ "Content-Type" => schema.media_type }) if schema.media_type
      end

      def add_security_headers!(h)
        return unless schema.secured_by

        scheme = security_schemes.find {|sch| sch.title == schema.secured_by.first }

        h.merge!(scheme.headers)
      end
    end
  end
end
