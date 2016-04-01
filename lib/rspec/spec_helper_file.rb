module Rambo
  module RSpec
    class SpecHelperFile

      TEMPLATE_PATH = File.expand_path('../templates/spec_helper_file_template.erb', __FILE__)

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end

      def render
        template
      end
    end
  end
end
