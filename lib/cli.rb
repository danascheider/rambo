require 'fileutils'

module Rambo
  class CLI
    attr_accessor :file, :stdout

    def initialize(stdout=STDOUT)
      @stdout = stdout
      @file = ARGV[0]
      run!
    end

    def create_spec_files!
      spec_file_name = file.gsub(/\.raml$/, '_spec.rb')
      FileUtils.mkdir_p "spec/contract"
      FileUtils.touch "spec/contract/#{spec_file_name}"
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

    protected
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