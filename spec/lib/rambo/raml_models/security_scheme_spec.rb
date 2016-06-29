RSpec.describe Rambo::RamlModels::SecurityScheme do
  let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/secured_api.raml") }
  let(:raml)      { Raml::Parser.parse_file(raml_file).security_schemes.first }

  subject { described_class.new(raml, { token: "foobarbaz" }) }

  it { is_expected.to respond_to :title }

  describe "#headers" do
    it "is a Headers object" do
      expect(subject.headers).to be_a(Rambo::RamlModels::Headers)
    end

    it "uses the API token from the options" do
      expect(subject.headers.headers).to eql({ "Api-Token" => "foobarbaz" })
    end
  end

  describe "#api_token_header" do
    it "returns the key of a matching header" do
      expect(subject.api_token_header).to eql "Api-Token"
    end
  end
end
