lib = File.expand_path("../../..", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "rake"
require "yaml"
require "colorize"
require "rambo"

module Rambo
  module Rake
    class Task
      include ::Rake::DSL

      def initialize
        define_task
      end

      private

      def define_task
        desc "Generate contract tests"
        task :rambo do
          Rambo.generate_contract_tests!

          puts "Done generating contract tests.".green
        end
      end
    end
  end
end
