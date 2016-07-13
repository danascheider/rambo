require "erb"
require "raml"
require "rambo/raml_models"
require "rambo/rspec/examples"

module Rambo
  module RSpec
    class HelperFile
      attr_reader :options

      def initialize(template_path:, file_path:, raml: nil, options: nil)
        @template_path = template_path
        @file_path     = file_path
        @options       = options || { framework: :rails }
        @raml          = raml ? Rambo::RamlModels::Api.new(raml) : nil
      end

      def app_classes
        {
          :rails             => "Rails.application",
          :"sinatra:classic" => "Sinatra::Application",
          :"sinatra:modular" => "Sinatra::Base.descendants.find {|klass| klass != Sinatra::Application } || Sinatra::Application",
          :grape             => "Grape::API.descendants.first"
        }
      end

      def generate
        write_to_file(render) unless file_already_exists?
      end

      def render
        b = binding
        ERB.new(template, 0, "-", "@result").result(raml.instance_eval { b })
        @result
      end

      private

      attr_reader :template_path, :file_path, :raml

      def file_already_exists?
        File.exist?(file_path)
      end

      def write_to_file(template)
        File.write(file_path, template)
      end

      def template
        @template ||= File.read(template_path)
      end
    end
  end
end
