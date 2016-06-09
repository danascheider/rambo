module Rambo
  module RSpec
    class ExampleGroup

      TEMPLATE_PATH = File.expand_path("../templates/example_group_template.erb", __FILE__)

      attr_reader :resource

      def initialize(resource, options={})
        @resource = resource
        @options  = options
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end

      def create_fixture_files
        resource.http_methods.each do |method|
          if method.request_body
            path = File.expand_path("spec/support/examples/#{@resource.to_s.gsub(/\//, "")}_#{method.method}_request_body.json")
            File.write(path, method.request_body.example)
          end

          method.responses.each do |resp|
            resp.bodies.each do |body|
              path     = body.schema ? response_schema_fixture_path(method) : response_body_fixture_path(method)
              contents = body.schema ? body.schema : body.example
              File.write(path, contents)
            end
          end
        end
      end

      def render
        create_fixture_files
        b = binding
        ERB.new(template, 0, "-", "@result").result(resource.instance_eval { b })
        @result
      end

      private

      def response_schema_fixture_path(method)
        File.expand_path("spec/support/examples/#{@resource.to_s.gsub(/\//, "")}_#{method.method}_response_schema.json")
      end

      def response_body_fixture_path(method)
        File.expand_path("spec/support/examples/#{@resource.to_s.gsub(/\//, "")}_#{method.method}_response_body.json")
      end
    end
  end
end
