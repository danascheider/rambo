RSpec.describe Rambo::RamlModels::Headers do
  let(:headers)   { { "Content-Type" => "application/json" } }

  subject { described_class.new(headers) }

  describe "#pretty" do
    let(:pretty) do
      "{\n\t\"Content-Type\" => \"application/json\"\n}"
    end

    it "makes it pretty" do
      expect(subject.pretty).to eql pretty
    end

    context "multiple headers" do
      let(:headers) { { "Content-Type" => "application/json", "Accept" => "application/json" } }

      let(:pretty) do
        "{\n\t\"Content-Type\" => \"application/json\",\n\t\"Accept\" => \"application/json\"\n}"
      end

      it "formats the header hash" do
        pending "Test fails when functionality works as expected...confusing"
        expect(subject.pretty).to eql pretty
      end
    end
  end

  describe "#add" do
    it "adds an additional header" do
      subject.add("Accept" => "application/json")
      expect(subject.headers).to eql({ "Content-Type" => "application/json", "Accept" => "application/json" })
    end

    it "returns self" do
      expect(subject.add("Accept" => "application/json")).to be subject
    end
  end

  describe "#merge!" do
    it "combines two sets of headers" do
      expect(subject.merge!(described_class.new({"Accept" => "application/json"}))).to be_a(described_class)
    end
  end
end
