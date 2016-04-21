describe Rambo::RamlModels::Response do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse_file(raml_file) }
  let(:response) { raml.resources.first.methods.first.responses.first }

  subject { described_class.new(response) }

  describe "#status_code" do
    it "returns the response status code" do
      expect(subject.status_code).to eql response.code
    end
  end

  describe "bodies" do
    it "creates an array of Body objects" do
      all_are_bodies = response.bodies.all? {|body| body.is_a?(Rambo::RamlModels::Body) }
      expect(all_are_bodies).to be true
    end
  end
end
