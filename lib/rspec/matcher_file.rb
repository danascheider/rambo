module Rambo
  module RSpec
    class MatcherFile

      MATCHER_FILE_PATH = "spec/support/matchers/rambo_matchers.rb"
      TEMPLATE_PATH     = File.expand_path("../templates/matcher_file_template.erb", __FILE__)

      def generate
        write_to_file(template) unless file_already_exists?
      end

      private

      def file_already_exists?
        File.exist?(MATCHER_FILE_PATH)
      end

      def write_to_file(template)
        File.open(MATCHER_FILE_PATH, "w+") {|f| f.puts template }
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end
    end
  end
end
