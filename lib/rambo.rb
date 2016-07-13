require "fileutils"
require "active_support/core_ext/hash"

Dir["#{File.dirname(__FILE__)}/rambo/**/*.rb"].each {|file| require file }

module Rambo
  class << self
    attr_reader :options, :file

    def generate_contract_tests!(file: nil, options: {})
      @options             = yaml_options.merge(options)
      @options[:framework] = :rails if @options.fetch(:framework, nil).nil?
      @file                = file || @options.delete(:raml) || raml_file

      DocumentGenerator.generate!(@file, @options)
    end

    private

    def yaml_options
      opts = YAML.load(File.read(File.join(FileUtils.pwd, ".rambo.yml"))).symbolize_keys

      opts[:framework] = opts[:framework].to_sym if opts[:framework]

      if opts && opts.fetch(:raml, nil)
        opts[:raml] = File.join(FileUtils.pwd, opts.fetch(:raml))
      end

      opts || {}
    rescue
      { framework: :rails }
    end

    # TODO: Permit use of multiple RAML files, since right now this only takes
    #       the first one it finds in the "doc" directory.

    def raml_file
      return options.fetch(:raml) if options && options.fetch(:raml, nil)

      raml_path = File.join(FileUtils.pwd, "doc", "raml")
      Dir.foreach(raml_path) {|file| return File.join(raml_path, file) if file.match(/\.raml$/) }
    end
  end
end
