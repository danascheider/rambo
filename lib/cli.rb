require_relative 'document_generator'

module Rambo
  class CLI
    def initialize(stdout=STDOUT)
      @stdout, @file, @generator = stdout, ARGV[0], Rambo::DocumentGenerator.new(ARGV[0])
    end

    def create_spec_files!
      generator.generate_spec_dir!
      generator.generate_spec_helper!
      generator.generate_spec_file!
    end

    def validate!
      if !file
        exit_missing_file
      elsif !file.match(/\.raml$/)
        exit_invalid_file_format
      end
    end

    def run!
      validate!
      create_spec_files!
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