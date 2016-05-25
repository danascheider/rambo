module Rambo
  module RSpec
    class HelperFile
      def initialize(template_path:, file_path:)
        @template_path = template_path
        @file_path     = file_path
      end

      def generate
        write_to_file(template) unless file_already_exists?
      end

      private

      attr_reader :template_path, :file_path

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
