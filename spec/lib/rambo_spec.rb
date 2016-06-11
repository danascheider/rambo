RSpec.describe Rambo do
  let(:file_contents) do
    <<-EOF
raml: doc/raml/foobar.raml
rails: false
    EOF
  end

  describe ".generate_contract_tests!" do
    let(:valid_file)      { File.join(SPEC_DIR_ROOT, "support/foobar.raml") }
    let(:default_options) { { rails: true } }

    before(:each) do
      allow(Dir).to receive(:foreach).and_return(valid_file)
    end

    context "in all cases" do
      it "generates documents" do
        expect(Rambo::DocumentGenerator).to receive(:generate!).with(valid_file, default_options)
        Rambo.generate_contract_tests!(valid_file, default_options)
      end
    end

    context "when there is a .rambo.yml file" do
      before(:each) do
        allow(Rambo::DocumentGenerator).to receive(:generate!)

        allow(File)
          .to receive(:read)
          .with(File.expand_path(".rambo.yml"))
          .and_return(file_contents)
      end

      it "reads from the file" do
        expect(File).to receive(:read).with(File.expand_path(".rambo.yml"))
        Rambo.generate_contract_tests!
      end

      it "sets the RAML file to the one from the file" do
        expect(Rambo::DocumentGenerator)
          .to receive(:generate!)
          .with(File.expand_path("doc/raml/foobar.raml"), { "raml" => File.expand_path("doc/raml/foobar.raml"), "rails" => false })

        Rambo.generate_contract_tests!
      end
    end

    context "when there is no .rambo.yml file" do
      it "uses default options" do
        expect(Rambo::DocumentGenerator).to receive(:generate!).with(valid_file, default_options)
        Rambo.generate_contract_tests!
      end
    end
  end
end
