RSpec.describe Rambo do
  let(:file_contents) do
    <<-EOF
raml: doc/raml/foobar.raml
framework: rails
    EOF
  end

  describe ".generate_contract_tests!" do
    let(:valid_file)      { "foobar.raml" }
    let(:default_options) { { framework: :rails } }

    before(:each) do
      allow(Dir).to receive(:foreach).and_return("/Users/dscheider/rambo/doc/raml/#{valid_file}")
    end

    context "in all cases" do
      it "generates documents" do
        expect(Rambo::DocumentGenerator).to receive(:generate!).with(valid_file, default_options)
        Rambo.generate_contract_tests!(file: valid_file, options: default_options)
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
          .with(File.expand_path("doc/raml/foobar.raml"), { framework: :rails })

        Rambo.generate_contract_tests!
      end

      context "framework set to sinatra:classic" do
        it "sets framework to sinatra:classic" do
          allow(Rambo).to receive(:yaml_options).and_return({ framework: :"sinatra:classic" })
          expect(Rambo::DocumentGenerator)
            .to receive(:generate!)
            .with("/Users/dscheider/rambo/doc/raml/#{valid_file}", { framework: :"sinatra:classic" })
          Rambo.generate_contract_tests!
        end
      end

      context "framework set to sinatra:modular" do 
        it "sets framework to sinatra:modular" do 
          allow(Rambo).to receive(:yaml_options).and_return({ framework: :"sinatra:modular" })
          expect(Rambo::DocumentGenerator)
            .to receive(:generate!)
            .with("/Users/dscheider/rambo/doc/raml/#{valid_file}", { framework: :"sinatra:modular" })
          Rambo.generate_contract_tests!
        end
      end

      context "framework set to Grape" do 
        it "sets framework to Grape" do 
          allow(Rambo).to receive(:yaml_options).and_return({ framework: :grape })
          expect(Rambo::DocumentGenerator)
            .to receive(:generate!)
            .with("/Users/dscheider/rambo/doc/raml/#{valid_file}", { framework: :grape })
          Rambo.generate_contract_tests!
        end
      end

      context "framework set to Rails" do
        it "sets framework to Rails" do
          allow(Rambo).to receive(:yaml_options).and_return({ framework: :rails })
          expect(Rambo::DocumentGenerator)
            .to receive(:generate!)
            .with("/Users/dscheider/rambo/doc/raml/#{valid_file}", { framework: :rails })
          Rambo.generate_contract_tests!
        end
      end

      context "framework option not set in file" do
        it "sets framework to Rails" do
          allow(Rambo).to receive(:yaml_options).and_return({})
          expect(Rambo::DocumentGenerator)
            .to receive(:generate!)
            .with(File.expand_path("/Users/dscheider/rambo/doc/raml/#{valid_file}"), { framework: :rails })
          Rambo.generate_contract_tests!
        end
      end
    end

    context "when there is no .rambo.yml file" do
      it "uses default options" do
        expect(Rambo::DocumentGenerator)
          .to receive(:generate!)
          .with(File.expand_path("/Users/dscheider/rambo/doc/raml/#{valid_file}"), default_options)

        Rambo.generate_contract_tests!
      end
    end
  end
end
