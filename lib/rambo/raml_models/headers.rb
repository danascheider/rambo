module Rambo
  module RamlModels
    class Headers
      attr_accessor :headers

      def initialize(headers)
        @headers = headers
      end

      def add(hash)
        headers.merge!(hash)
        self
      end

      def merge!(other)
        add(other.headers)
      end

      def pretty
        JSON.pretty_generate(headers).gsub("\":", "\" =>")
      end
    end
  end
end
