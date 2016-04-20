describe Rambo::RamlModels::Method do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse_file(raml_file) }
  let(:method) { raml.resources.first.methods.first }

  subject { described_class.new(method) }

  describe "#to_s" do
    it "returns the method name" do
      expect(subject.to_s).to eql method.method.upcase
    end
  end
end
