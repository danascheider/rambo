module Rambo
  module RamlModels
    class Headers
      attr_accessor :headers

      def initialize(headers)
        @headers = headers
      end

      def pretty
        beginning, ending = "{\n", "}"

        contents = headers.map {|key, value|
          "\t\"#{key}\" => \"#{value}\"\n"
        }

        "#{beginning}#{contents.join}#{ending}"
      end
    end
  end
end
