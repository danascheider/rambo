describe Rambo::RamlModels::Body do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse_file(raml_file) }
  let(:body) { raml.resources.first.methods.first.responses.first.bodies.first }

  subject { described_class.new(body) }

  describe "#content_type" do
    it "returns the content type" do
      expect(subject.content_type).to eql body.content_type
    end
  end
end
