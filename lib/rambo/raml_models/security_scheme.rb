module Rambo
  module RamlModels
    class SecurityScheme
      attr_accessor :schema, :title
      private :schema

      def initialize(raml, options={})
        @options        = options
        @schema, @title = raml.last.fetch("describedBy", {}), raml.first
        use_token!
      end

      def use_token!
        if schema.fetch("headers", nil)
          schema.fetch("headers")[api_token_header] = @options[:token]
        end
      end

      def api_token_header
        return unless h = schema.fetch("headers", nil)

        h.find {|key, value| key.match(/(token|key)/i) }.first
      end

      def headers
        @headers ||= Rambo::RamlModels::Headers.new(schema.fetch("headers") || {})
      end
    end
  end
end
