require "colorize"
require "rambo"

module Rambo
  class CLI
    def initialize(raml_file=nil, opts={}, stdout=STDOUT, stderr=STDERR)
      @stdout  = stdout
      @stderr  = stderr
      @file    = raml_file
      @options = opts

      validate!
    end

    def run!
      print_logo

      begin
        Rambo.generate_contract_tests!(file, options)

        stdout.puts("Generating contract tests...")
        sleep 0.4

        stdout.puts("Done!".green)
      rescue NoMethodError => e
        stderr.puts("Error: #{e.message}".red)
        stderr.puts "\t#{e.backtrace.join("\n\t")}"
      end
    end

    def validate!
      exit_for_missing_file unless file
      exit_for_invalid_file_format unless file.match(/\.raml$/)
    end

    private

    attr_accessor :file, :stdout, :stderr, :generator, :options

    def print_logo
      stdout.puts logo.colorize(color: String.colors.sample)
      sleep 0.4
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
