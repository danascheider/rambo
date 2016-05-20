RSpec.describe Rambo::DocumentGenerator do
  let(:valid_file) { File.expand_path('../../support/foobar.raml', __FILE__) }
  let(:generator) { Rambo::DocumentGenerator.new(valid_file) }

  before(:each) do
    allow_any_instance_of(Rambo::DocumentGenerator).to receive(:extract_raml)
  end

  describe "#generate_spec_dir!" do
    it "generates the spec/contract directory" do
      expect(FileUtils).to receive(:mkdir_p).with("spec/contract")
      generator.generate_spec_dir!
    end
  end

  describe "#generate_rambo_helper!!" do
    it "generates the rambo_helper file" do
      allow(File).to receive(:exist?).with("spec/rambo_helper.rb").and_return(true)
      expect(File).to receive(:exist?).with("spec/rambo_helper.rb")
      generator.generate_rambo_helper!
    end
  end

  describe "#generate_spec_file!" do
    before(:each) do
      allow(File).to receive(:open)
    end

    it "generates foobar_spec.rb" do
      allow_any_instance_of(Rambo::RSpec::SpecFile).to receive(:render)
      expect(File).to receive(:open).with("spec/contract/foobar_spec.rb", "w+")
      generator.generate_spec_file!
    end
  end
end
