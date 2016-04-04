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

      def ensure_requires_present!
        ensure_requires!('json', 'rack/test')
        contents
      end

      def requires
        contents.match(/((require ('|")\S+('|")\n)+)/)[0]
      end

      def ensure_requires!(*reqs)
        reqs.reject! {|req| required?(req) }

        contents.gsub!(requires, append_requires(*reqs))
      end

      def append_requires(*reqs)
        new_requires = requires
        reqs.each {|req| new_requires << "require \"#{req}\"\n" }
        new_requires
      end

      def required?(req)
        contents.match(/require ('|")#{req}('|")/)
      end

      def template
        @template ||= File.read(TEMPLATE_PATH)
      end
    end
  end
end
