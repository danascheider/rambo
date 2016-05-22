module Rambo
  module RSpec
    class RamboHelperFile

      TEMPLATE_PATH     = File.expand_path("../templates/rambo_helper_file_template.erb", __FILE__)
      RAMBO_HELPER_PATH = "spec/rambo_helper.rb"

      def generate
        write_to_file(template) unless file_already_exists?
      end

      private

      def file_already_exists?
        File.exist?(RAMBO_HELPER_PATH)
      end

      def write_to_file(template)
        File.open(RAMBO_HELPER_PATH, "w+") { |f| f.puts template }
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end
    end
  end
end
