module Rambo
  module RSpec
    class SpecHelperFile

      TEMPLATE_PATH = File.expand_path('../templates/spec_helper_file_template.erb', __FILE__)

      def initialize
        @contents = File.read('spec/spec_helper.rb') if File.exist?('spec/spec_helper.rb')
      end

      def render
        contents ? ensure_requires_present! : template
      end

      private

      attr_accessor :contents

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end
    end
  end
end
