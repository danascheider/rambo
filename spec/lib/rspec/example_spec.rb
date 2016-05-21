require "spec_helper"

RSpec.describe Rambo::RSpec::Example do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml)      { RamlParser::Parser.parse_file(raml_file) }
  let(:method)    { raml.resources.first.methods.first }

  subject         { Rambo::RSpec::Example.new(resource: resource) }
end
