RSpec.describe Rambo::RamlModels::Api do
  let(:raml_file) { File.expand_path("../../../support/multiple_resources.raml", __FILE__) }
  let(:raml)      { RamlParser::Parser.parse_file(raml_file) }

  subject { described_class.new(raml) }

  describe "#resources" do
    it "has the right number of resources" do
      expect(subject.resources.count).to eql 2
    end

    it "returns an array of Resource objects" do
      all_are_resources = subject.resources.all? {|resource| resource.is_a?(Rambo::RamlModels::Resource) }
      expect(all_are_resources).to be true
    end
  end

  describe "#title" do
    it "returns the API title from the RAML doc" do
      expect(subject.title).to eql raml.title
    end
  end
end
