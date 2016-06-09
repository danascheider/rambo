RSpec.describe Rambo::Rake::Task do
  describe "#initialize" do
    let(:file_contents) do
      <<-EOF
raml: doc/raml/foobar.raml
rails: false
      EOF
    end

    context "when there is a .rambo.yml" do
      it "reads options from .rambo.yml" do
        expect(File).to receive(:read).with(File.expand_path(".rambo.yml"))
        described_class.new
      end

      it "assigns the correct options" do
        allow(File).to receive(:read).with(File.expand_path(".rambo.yml")).and_return(file_contents)
        expect(subject.options).to eql({ "raml" => File.expand_path("doc/raml/foobar.raml"), "rails" => false })
      end
    end

    context "when there is no .rambo.yml" do
      it "doesn't raise an error" do
        expect{ subject.yaml_options }.not_to raise_error
      end

      it "uses default options" do
        expect(subject.yaml_options).to eql({ "rails" => true })
      end
    end
  end
end
