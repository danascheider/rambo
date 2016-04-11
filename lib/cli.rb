require "colorize"
require File.expand_path("../document_generator.rb", __FILE__)

module Rambo
  class CLI
    def initialize(raml_file=nil, stdout=STDOUT)
      @stdout = stdout
      @file   = raml_file

      validate!

      @generator = Rambo::DocumentGenerator.new(file)
    end

    def run!
      print_logo
      generator.generate_spec_dir!
      generator.generate_spec_helper!
      generator.generate_spec_file!
    end

    def validate!
      exit_for_missing_file unless file
      exit_for_invalid_file_format unless file.match(/\.raml$/)
    end

    private

    attr_accessor :file, :stdout, :generator

    def print_logo
      stdout.puts logo.colorize(color: String.colors.sample)
      sleep 0.5
      stdout.puts "Generating contract tests..."
      sleep 0.5
      stdout.puts "Done!\n".green
    end

    def exit_for_missing_file
      stdout.puts "USAGE: rambo [FILE]"
      exit 1
    end

    def exit_for_invalid_file_format
      stdout.puts "Unsupported file format. Please choose a RAML file."
      exit 1
    end

    def logo
      File.read(File.expand_path("../../assets/logo.txt", __FILE__))
    end
  end
end
