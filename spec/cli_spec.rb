require 'spec_helper'

describe Rambo::CLI do
  let(:io) { StringIO.new }

  describe "initialize" do
    before(:each) do
      allow(FileUtils).to receive(:mkdir_p)
      allow(FileUtils).to receive(:touch)
    end

    it "sets the file" do
      ARGV[0] = 'foobar.raml'
      cli = Rambo::CLI.new(io)
      expect(cli.file).to eql 'foobar.raml'
    end

    it "runs" do
      ARGV[0] = 'foobar.raml'
      expect_any_instance_of(Rambo::CLI).to receive(:run!)
      cli = Rambo::CLI.new(io)
    end
  end

  describe "run!" do
    before(:each) do
      allow(FileUtils).to receive(:mkdir_p).with('spec/contract')
      allow(FileUtils).to receive(:touch).with('spec/contract/foobar_spec.rb')
    end

    it "validates the file" do
      cli = Rambo::CLI.new(io)
      expect_any_instance_of(Rambo::CLI).to receive(:validate!)
      cli.run!
    end

    it "creates a spec/contract directory" do
      cli = Rambo::CLI.new(io)
      expect(FileUtils).to receive(:mkdir_p).with('spec/contract')
      cli.run!
    end

    it "creates foobar_spec.rb" do
      ARGV[0] = 'foobar.raml'
      cli = Rambo::CLI.new(io)
      expect(FileUtils).to receive(:touch).with('spec/contract/foobar_spec.rb')
      cli.run!
    end
  end

  describe "validate!" do
    before(:each) do
      allow(FileUtils).to receive(:mkdir_p).twice
      allow(FileUtils).to receive(:touch).twice
      allow_any_instance_of(Rambo::CLI).to receive(:run!)
    end

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