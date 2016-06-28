RSpec.describe Rambo::RamlModels::Headers do
  let(:raml)      { Raml::Parser.parse_file(raml_file) }
  let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/post_with_request_headers.raml") }
  let(:headers)   { raml.resources.first.methods.first.headers }

  subject { described_class.new(headers) }

  describe "#pretty" do
    let(:pretty) do
      "{\n\t\"Content-Type\" => \"application/json\"\n}"
    end

    it "makes it pretty" do
      expect(subject.pretty).to eql pretty
    end

    context "multiple headers" do
      let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/multiple_headers.raml") }

      let(:pretty) do
        "{\n\t\"Content-Type\" => \"application/json\"\n\t\"Accept\" => \"application/json\"\n}"
      end

      it "formats the header hash" do
        require "pry"
        binding.pry
        expect(subject.pretty).to eql pretty
      end
    end
  end
end
