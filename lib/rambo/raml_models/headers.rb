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
        beginning = "{\n"
        ending    = "}"

        contents = headers.to_a.map {|pair|
          "\t\"#{pair.first}\" => \"#{pair.last}\"\n"
        }

        "#{beginning}#{contents.join("")}#{ending}"
      end
    end
  end
end
