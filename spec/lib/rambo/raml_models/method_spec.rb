RSpec.describe Rambo::RamlModels::Method do
  let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/raml_with_media_type.raml") }
  let(:raml)      { Raml::Parser.parse_file(raml_file) }
  let(:method)    { raml.resources.first.methods.first }
  let(:headers)   { Rambo::RamlModels::Headers.new({ "Accept" => "application/json" }) }

  subject { described_class.new(method, headers) }

  describe "#to_s" do
    it "returns the method name" do
      expect(subject.method).to eql method.method
    end
  end

  describe "#description" do
    it "returns the description" do
      expect(subject.description).to eql method.description
    end
  end

  describe "#request_body" do
    let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/post_with_request_headers.raml") }

    it "returns a request body" do
      expect(subject.request_body).to be_a Rambo::RamlModels::Body
    end
  end

  describe "#responses" do
    it "returns an array of Response objects" do
      all_are_responses = subject.responses.all? {|resp| resp.is_a?(Rambo::RamlModels::Response) }
      expect(all_are_responses).to be true
    end
  end
end
