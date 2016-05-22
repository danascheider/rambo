RSpec.describe Rambo::RamlModels::Resource do
  let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse_file(raml_file) }
  let(:uri_partial) { raml.resources.first.first }
  let(:resource) { raml.resources.first }

  subject { described_class.new(resource) }

  describe "#to_s" do
    it "returns the URI partial" do
      expect(subject.to_s).to eql uri_partial
    end
  end

  describe "#uri_partial" do
    it "returns the URI partial" do
      expect(subject.uri_partial).to eql resource.first
    end
  end

  describe "#http_methods" do
    it "returns the correct methods" do
      expect(subject.http_methods.count).to eql 1
    end

    it "returns an array of Method objects" do
      all_are_methods = subject.http_methods.all? {|method| method.is_a?(Rambo::RamlModels::Method) }
      expect(all_are_methods).to be true
    end
  end
end
