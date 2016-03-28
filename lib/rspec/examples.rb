require_relative './example_group'

module Rambo
  module RSpec
    class Examples
      attr_reader :raml, :resources, :examples

      def initialize(raml:)
        @raml      = raml
        @resources = raml.resources
      end

      def compose
        return '' unless examples

        examples.join("\n\n")
      end

      def example_groups
        @example_groups ||= resources.map {|r| ExampleGroup.new(resource: r) }
      end

      def generate!
        @examples = example_groups.map(&:render)
      end
    end
  end
end
