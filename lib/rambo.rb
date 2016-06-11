Dir["#{File.dirname(__FILE__)}/rambo/**/*.rb"].each {|file| require file }

module Rambo
  class << self
    def generate_contract_tests!(file = nil, opts = nil)
      @file = file || raml_file
      @options = opts || yaml_options

      DocumentGenerator.generate!(@file, @options)
    end

    private

    attr_reader :options

    def yaml_options
      opts = YAML.load(File.read(File.expand_path(".rambo.yml")))

      if opts && opts.fetch("raml", nil)
        opts["raml"] = File.expand_path(opts.fetch("raml"))
      end

      opts
    rescue
      { rails: true }
    end

    # TODO: Permit use of multiple RAML files, since right now this only takes
    #       the first one it finds in the "doc" directory.

    def raml_file
      return options.fetch("raml") if options && options.fetch("raml", nil)
      Dir.foreach("doc/raml") {|file| return "doc/raml/#{file}" if file.match(/\.raml$/) }
    end
  end
end
