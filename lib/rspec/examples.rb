module Rambo
  module RSpec
    class Examples
      attr_reader :raml, :resources

      def initialize(raml:)
        @raml      = raml
        @resources = raml.resources
      end

      def generate!
        @example_groups = @resources.map {|r| ExampleGroup.new(resource: r) }
      end
    end
  end
end
