require 'erb'
require 'raml-rb'

require File.expand_path('../examples.rb', __FILE__)

module Rambo
  module RSpec
    class SpecFile
      attr_reader :raml, :examples

      TEMPLATE_PATH = File.expand_path('../templates/spec_file_template.erb', __FILE__)

      def initialize(raml)
        @raml     = raml
        @examples = Examples.new(raml)
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end

      def render
        b = binding
        ERB.new(template, 0, "", "@result").result(raml.instance_eval { b })
        @result
      end
    end
  end
end
