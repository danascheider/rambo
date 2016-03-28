require 'colorize'
require_relative 'document_generator'

module Rambo
  class CLI
    def initialize(raml_file=nil, stdout=STDOUT)
      @stdout = stdout
      @file = raml_file

      validate!

      @generator = Rambo::DocumentGenerator.new(file)
    end

    def print_logo
      logo = File.read(File.expand_path('../../assets/logo.txt', __FILE__))

      @stdout.puts logo.colorize(color: String.colors.sample)
      sleep 0.5
      @stdout.puts "Generating contract tests..."
      sleep 0.5
      @stdout.puts "Done!\n".green
    end

    def validate!
      exit_missing_file unless file
      exit_invalid_file_format unless file.match(/\.raml$/)
    end

    def run!
      print_logo
      generator.generate_spec_dir!
      generator.generate_spec_helper!
      generator.generate_spec_file!
    end

    private
      attr_accessor :file, :stdout, :generator

      def exit_missing_file
        stdout.puts "USAGE: rambo [FILE]"
        exit 1
      end

      def exit_invalid_file_format
        stdout.puts "Unsupported file format. Please choose a RAML file."
        exit 1
      end
  end
end
