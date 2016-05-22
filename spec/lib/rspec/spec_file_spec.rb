RSpec.describe Rambo::RSpec::SpecFile do
  let(:raw_raml)  { Raml::Parser.parse_file(raml_file) }
  let(:raml)      { Rambo::RamlModels::Api.new(raw_raml) }
  let(:spec_file) { Rambo::RSpec::SpecFile.new(raw_raml) }

  context "file with examples" do
    let(:raml_file) { File.expand_path("../../../support/foobar.raml", __FILE__) }

    describe "#initialize" do
      it "assigns @raml" do
        expect(spec_file.raml).to be_a Rambo::RamlModels::Api
      end

      it "uses the correct schema" do
        expect(spec_file.raml.schema).to eq raw_raml
      end
    end

    describe "#template" do
      it "is a string" do
        expect(spec_file.template.is_a?(String)).to be true
      end
    end

    describe "#render" do
      it "interpolates the correct values" do
        expect(spec_file.render).to include("e-BookMobile API")
      end
    end
  end

  context "file with schema" do
    let(:raml_file) do
      File.expand_path("features/support/examples/raml/basic_raml_with_schema.raml")
    end

    describe "#initialize" do
      it "assigns @raml" do
        expect(spec_file.raml).to be_a(Rambo::RamlModels::Api)
      end
    end

    describe "#template" do
      it "is a string" do
        expect(spec_file.template.is_a?(String)).to be true
      end
    end

    describe "#render" do
      let(:test_data) { '"data" => 1' }

      it "interpolates the correct values" do
        allow(JsonTestData).to receive(:generate!).and_return({ :data => 1 })
        expect(spec_file.render).to include(test_data)
      end
    end
  end
end
