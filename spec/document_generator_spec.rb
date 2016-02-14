require 'spec_helper'

describe Rambo::DocumentGenerator do
  let(:generator) { Rambo::DocumentGenerator.new('foobar.raml') }

  describe "#generate_spec_dir!" do
    it "generates the spec/contract directory" do
      expect(FileUtils).to receive(:mkdir_p).with("spec/contract")
      generator.generate_spec_dir!
    end
  end

  describe "#generate_spec_helper!" do
    it "generates the spec_helper file" do
      expect(FileUtils).to receive(:touch).with("spec/spec_helper.rb")
      generator.generate_spec_helper!
    end
  end

  describe "#generate_spec_file!" do
    before(:each) do
    end

    it "generates foobar_spec.rb" do
      expect(File).to receive(:open).with("spec/contract/foobar_spec.rb", "w+")
      generator.generate_spec_file!
    end
  end
end