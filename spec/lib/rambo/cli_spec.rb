RSpec.describe Rambo::CLI do
  let(:io)         { StringIO.new }
  let(:stderr)     { StringIO.new }
  let(:opts)       { { rails: true } }
  let(:valid_file) { File.join(SPEC_DIR_ROOT, 'support/foobar.raml',) }

  describe "run!" do
    let(:cli) { Rambo::CLI.new(valid_file, opts, io, stderr) }

    before(:each) do
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_rambo_helper!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_file!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_matchers!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_matcher_dir!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_examples!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_dir!)
    end

    it "creates a spec/contract directory" do
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_dir!)
      cli.run!
    end

    it "creates a spec/support/matchers directory" do
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_matchers!)
      cli.run!
    end

    it "creates a rambo_helper file" do
      allow(File).to receive(:exist?).with('spec/rambo_helper.rb').and_return(true)
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_rambo_helper!)
      cli.run!
    end

    it "creates foobar_spec.rb" do
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_file!)
      cli.run!
    end

    it "creates the spec/support/examples directory" do
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_examples!)
      cli.run!
    end

    context "when there is an error" do
      it "prints the error messaage" do
        allow_any_instance_of(Rambo::DocumentGenerator)
          .to receive(:generate_spec_file!)
          .and_raise NoMethodError, "Undefined method generate_spec_file!"

        expect{ cli.run! }.to rescue(NoMethodError)
      end
    end
  end

  describe "validate!" do
    context "with no file given" do
      it "exits" do
        expect{ Rambo::CLI.new(nil, io) }.to raise_error(SystemExit)
      end
    end

    context "with the wrong file format" do
      let(:invalid_file) { File.expand_path('../support/foobar.yml', __FILE__) }

      it "exits" do
        expect{ Rambo::CLI.new(invalid_file, io) }.to raise_error(SystemExit)
      end
    end
  end
end
