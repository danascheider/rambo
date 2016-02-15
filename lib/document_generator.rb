require 'fileutils'
require 'raml-rb'

module Rambo
  class DocumentGenerator
    attr_accessor :file, :raml

    def initialize(file)
      @file = file
      File.open(file, 'r+') {|file| @raml = Raml::Parser.parse(file.read) }
    end

    def generate_spec_dir!
      FileUtils.mkdir_p('spec/contract')
    end

    def generate_spec_file!
      spec_file_name = file.match(/[^\/]*\.raml$/).to_s.gsub(/\.raml$/, '_spec.rb')
      File.open("spec/contract/#{spec_file_name}", "w+") do |file|
        file.puts <<-EOF
require 'spec_helper'

describe '#{@raml.title}' do
  include Rack::Test::Methods
end
EOF
      end
    end

    def generate_spec_helper!
      unless File.exist?("spec/spec_helper.rb")
        puts "The file does not exist"
        File.open("spec/spec_helper.rb", "a+") do |file|
          file.puts "\nrequire 'rack/test'"
        end
      end
    end
  end
end