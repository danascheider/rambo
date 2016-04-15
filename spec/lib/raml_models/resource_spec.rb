describe Rambo::RamlModels::Resource do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse_file(raml_file) }
  let(:resource) { raml.resources.first }

  subject { described_class.new(resource) }

  describe "to_s" do
    it "returns the URI partial" do
      expect(subject.to_s).to eql resource.uri_partial
    end
  end
end
