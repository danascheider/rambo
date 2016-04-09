require 'spec_helper'

describe Rambo::CLI do
  let(:io) { StringIO.new }
  let(:valid_file) { File.expand_path('../../support/foobar.raml', __FILE__) }

  describe "run!" do
    let(:cli) { Rambo::CLI.new(valid_file, io) }

    it "creates a spec/contract directory" do
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_helper!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_file!)
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_dir!)
      cli.run!
    end

    it "creates a spec_helper file" do
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_dir!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_file!)
      allow(File).to receive(:exist?).with('spec/spec_helper.rb').and_return(true)
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_helper!)
      cli.run!
    end

    it "creates foobar_spec.rb" do
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_helper!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_dir!)
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_file!)
      cli.run!
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
