require 'fileutils'

module Rambo
  class DocumentGenerator
    attr_accessor :file

    def initialize(file)
      @file = file
    end

    def generate_spec_dir!
      FileUtils.mkdir_p('spec/contract')
    end

    def generate_spec_file!
      spec_file_name = file.gsub(/\.raml$/, '_spec.rb')
      File.open("spec/contract/#{spec_file_name}", "w+") do |file|
        file.puts "require 'spec_helper'"
      end
    end

    def generate_spec_helper!
      FileUtils.touch "spec/spec_helper.rb"
    end
  end
end