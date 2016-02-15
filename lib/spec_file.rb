require 'erb'
require 'raml-rb'

module Rambo
  class SpecFile
    attr_reader :raml

    TEMPLATE_PATH = File.expand_path('../templates/spec_file_template.erb', __FILE__)
    
    def initialize(raml:)
      @raml = raml
    end

    def template
      File.open(TEMPLATE_PATH, 'r+') {|f| @template ||= f.read }
    end

    def render
      b = binding
      ERB.new(template, 0, "", "@result").result(raml.instance_eval { b })
      @result
    end
  end
end