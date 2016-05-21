RSpec.describe Rambo::RSpec::ExampleGroup do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml)      { RamlParser::Parser.parse_file(raml_file) }
  let(:resource)  { Rambo::RamlModels::Resource.new(raml.resources.first) }

  subject         { Rambo::RSpec::ExampleGroup.new(resource) }

  describe "#render" do
    it "interpolates the correct values" do
      aggregate_failures do
        expect(subject.render).to include("describe \"#{raml.resources.first.uri_partial}\" do")
        expect(subject.render).to include('describe "GET" do')
      end
    end
  end
end
