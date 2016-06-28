module Rambo
  module RamlModels
    class Headers
      attr_accessor :headers

      def initialize(headers)
        @headers = headers
      end

      def add(hash)
        @headers.merge!(hash)
        self
      end

      def pretty
        beginning, ending = "{\n", "}"

        contents = headers.to_a.each_with_index.map {|pair|
          if headers.to_a.index(pair) == headers.length - 1
            "\t\"#{pair.first}\" => \"#{pair.last}\"\n" # No comma after last item
          else
            "\t\"#{pair.first}\" => \"#{pair.last}\",\n"
          end
        }

        "#{beginning}#{contents.join}#{ending}"
      end
    end
  end
end
