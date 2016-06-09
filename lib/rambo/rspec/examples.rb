require "rspec/example_group"

module Rambo
  module RSpec
    class Examples
      attr_reader :raml, :resources, :examples, :options

      def initialize(raml, options={})
        @raml    = raml
        @options = options
      end

      def compose
        return '' unless examples

        examples.join("\n\n")
      end

      def resources
        @resources ||= raml.resources
      end

      def example_groups
        @example_groups ||= resources.map {|r| ExampleGroup.new(r, options) }
      end

      def generate!
        @examples = example_groups.map(&:render)
      end
    end
  end
end
