module Rambo
  module RSpec
    class Examples
      attr_reader :raml, :resources

      def initialize(raml:)
        @raml      = raml
        @resources = raml.resources
      end

      def example_groups
        @example_groups ||= resources.map {|r| ExampleGroup.new(resource: r) }
      end

      def generate!
        example_groups.map(&:render)
      end
    end
  end
end
