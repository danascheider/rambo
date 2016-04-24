describe Rambo::RamlModels::Method do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse_file(raml_file) }
  let(:method) { raml.resources.first.methods.first }

  subject { described_class.new(method) }

  describe "#to_s" do
    it "returns the method name" do
      expect(subject.to_s).to eql method.method
    end
  end

  describe "#description" do
    it "returns the description" do
      expect(subject.description).to eql method.description
    end
  end

  describe "#responses" do
    it "returns an array of Response objects" do
      all_are_responses = subject.responses.all? {|resp| resp.is_a?(Rambo::RamlModels::Response) }
      expect(all_are_responses).to be true
    end
  end
end
