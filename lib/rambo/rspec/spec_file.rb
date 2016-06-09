require 'erb'
require 'raml'

require "rspec/examples"
require "raml_models"

module Rambo
  module RSpec
    class SpecFile
      attr_reader :raml, :examples, :options

      TEMPLATE_PATH = File.expand_path('../templates/spec_file_template.erb', __FILE__)

      def initialize(raml, options={})
        @raml     = Rambo::RamlModels::Api.new(raml)
        @options  = options
        @examples = Examples.new(@raml, @options)
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end

      def render
        b = binding
        ERB.new(template, 0, "-", "@result").result(raml.instance_eval { b })
        @result
      end
    end
  end
end
