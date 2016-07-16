RSpec.describe Rambo::RSpec::ExampleGroup do
  let(:raml_file) { File.join(SPEC_DIR_ROOT, "/support/foobar.raml") }
  let(:raml)      { Raml::Parser.parse_file(raml_file) }
  let(:resource)  { Rambo::RamlModels::Resource.new(raml.resources.first) }
  let(:options)   { { framework: :rails, models: true } }
  subject         { Rambo::RSpec::ExampleGroup.new(resource, options) }

  before(:each) do
    FileUtils.mkdir_p(File.expand_path("spec/support/examples"))
  end

  after(:each) do
    FileUtils.rm_rf(File.expand_path("spec/support/examples"))
  end

  describe "#render" do
    it "interpolates the correct values" do
      aggregate_failures do
        expect(subject.render).to include("let(:output_file) do")
        expect(subject.render).to include("describe \"#{raml.resources.first.http_methods.first.method.upcase}\" do")
        expect(subject.render).to include('describe "GET" do')
      end
    end

    it "does not include a request body" do
      expect(subject.render).not_to include("let(:request_body) do")
    end

    it "does not include headers" do
      expect(subject.render).not_to include("let(:headers) do")
    end

    context "when the route has a response schema" do
      let(:raml_file) {File.join(SPEC_DIR_ROOT, "support/basic_raml_with_post_route.raml") }

      it "creates a response schema object" do
        aggregate_failures do
          expect(subject.render).to include("let(:response_schema) do")
          expect(subject.render).to include("expect(last_response.body).to match_schema response_schema")
        end
      end
    end

    context "when there is a response example but not a response schema" do
      it "creates a response_body object" do
        aggregate_failures do
          expect(subject.render).to include("let(:response_body) do")
          expect(subject.render).to include("expect(last_response.body).to eql response_body")
        end
      end
    end

    context "when the route has a request body" do
      let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/basic_raml_with_post_route.raml") }

      it "adds a request body" do
        expect(subject.render).to include("let(:request_body) do")
      end

      it "does not include headers" do
        expect(subject.render).not_to include("let(:headers) do")
      end
    end

    context "when the route has request headers" do
      let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/post_with_request_headers.raml") }

      it "adds headers" do
        expect(subject.render).to include("let(:headers) do")
      end
    end

    context "when the route has a model" do 
      it "creates models" do 
        expect(subject.render).to include("let!(:authors) { FactoryGirl.create_list(:author, 3) }")
      end
    end

    context "when the route doesn't have models" do 
      subject { described_class.new(resource, { rails: true, models: false }) }
      it "doesn't create models" do 
        expect(subject.render).not_to include("let!(:authors) { FactoryGirl.create_list(:author, 3) }")
      end
    end
  end
end
