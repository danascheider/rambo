module Rambo
  module RSpec
    class SpecHelperFile
      def initialize
        File.exist?('spec/spec_helper.rb') ? modify! : generate!
      end

      def generate!; end

      def modify!; end
    end
  end
end
