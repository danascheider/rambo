require 'spec_helper'

describe Rambo::CLI do
  let(:io) { StringIO.new }

  describe "run!" do
    it "validates the file" do
      ARGV[0] = 'foobar.raml'
      cli = Rambo::CLI.new(io)
      allow_any_instance_of(Rambo::CLI).to receive(:create_spec_files!)
      expect_any_instance_of(Rambo::CLI).to receive(:validate!)
      cli.run!
    end

    it "creates the spec files" do
      cli = Rambo::CLI.new(io)
      expect_any_instance_of(Rambo::CLI).to receive(:create_spec_files!)
      cli.run!
    end
  end

  describe "create_spec_files!" do
    it "creates a spec/contract directory" do
      cli = Rambo::CLI.new(io)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_helper!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_file!)
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_dir!)
      cli.create_spec_files!
    end

    it "creates a spec_helper file" do
      ARGV[0] = 'foobar.raml'
      cli = Rambo::CLI.new(io)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_dir!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_file!)
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_helper!)
      cli.create_spec_files!
    end

    it "creates foobar_spec.rb" do
      ARGV[0] = 'foobar.raml'
      cli = Rambo::CLI.new(io)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_helper!)
      allow_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_dir!)
      expect_any_instance_of(Rambo::DocumentGenerator).to receive(:generate_spec_file!)
      cli.create_spec_files!
    end
  end

  describe "validate!" do
    context "no file given" do
      it "exits" do
        ARGV[0] = nil
        cli = Rambo::CLI.new(io)
        expect{ cli.validate! }.to raise_error(SystemExit)
      end
    end

    context "with the wrong file format" do
      it "exits" do
        ARGV[0] = 'foobar.yml'
        cli = Rambo::CLI.new(io)
        expect{ cli.validate! }.to raise_error(SystemExit)
      end
    end
  end
end