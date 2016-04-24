module Rambo
  module RSpec
    class ExampleGroup
      TEMPLATE_PATH = File.expand_path('../templates/example_group_template.erb', __FILE__)

      attr_reader :resource

      def initialize(resource)
        @resource = resource
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end

      def render
        b = binding
        ERB.new(template, 0, "", "@result").result(resource.instance_eval { b })
        @result
      end
    end
  end
end
