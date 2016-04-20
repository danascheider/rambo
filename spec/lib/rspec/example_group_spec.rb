describe Rambo::RSpec::ExampleGroup do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml)      { Raml::Parser.parse(File.read(raml_file)) }
  let(:resource)  { raml.resources.first }

  subject         { Rambo::RSpec::ExampleGroup.new(resource: resource) }

  describe "#render" do
    it "interpolates the correct values" do
      aggregate_failures do
        expect(subject.render).to include("describe \"#{raml.resources.first.uri_partial}\" do")
        expect(subject.render).to include('describe "GET" do')
      end
    end
  end
end
