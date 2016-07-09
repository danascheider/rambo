RSpec.describe Rambo::DocumentGenerator do
  let(:valid_file) { File.join(SPEC_DIR_ROOT, "support/foobar.raml") }
  let(:options)    { { rails: true } }
  
  subject          { described_class.new(valid_file, options) }

  before(:each) do
    allow_any_instance_of(Rambo::DocumentGenerator).to receive(:extract_raml)
  end

  describe ".generate!" do
    before(:each) do
      allow_any_instance_of(described_class).to receive(:generate_matchers!)
      allow_any_instance_of(described_class).to receive(:generate_spec_dir!)
      allow_any_instance_of(described_class).to receive(:generate_spec_file!)
      allow_any_instance_of(described_class).to receive(:generate_matcher_dir!)
      allow_any_instance_of(described_class).to receive(:generate_rambo_helper!)
      allow_any_instance_of(described_class).to receive(:generate_examples!)
    end

    it "generates a spec directory" do
      expect_any_instance_of(described_class).to receive(:generate_spec_dir!)
      described_class.generate!(valid_file, options)
    end

    it "generates the Rambo helper" do
      expect_any_instance_of(described_class).to receive(:generate_rambo_helper!)
      described_class.generate!(valid_file, options)
    end

    it "generates the matcher directory" do
      expect_any_instance_of(described_class).to receive(:generate_matcher_dir!)
      described_class.generate!(valid_file, options)
    end

    it "generates the matchers" do
      expect_any_instance_of(described_class).to receive(:generate_matchers!)
      described_class.generate!(valid_file, options)
    end

    it "generates the examples" do
      expect_any_instance_of(described_class).to receive(:generate_examples!)
      described_class.generate!(valid_file, options)
    end

    it "generates a spec file" do
      expect_any_instance_of(described_class).to receive(:generate_spec_file!)
      described_class.generate!(valid_file, options)
    end
  end

  describe "#generate_spec_dir!" do
    it "generates the spec/contract directory" do
      expect(FileUtils).to receive(:mkdir_p).with("spec/contract/output")
      subject.generate_spec_dir!
    end
  end

  describe "#generate_rambo_helper!" do

    it "generates the rambo_helper file" do
      aggregate_failures do
        expect_any_instance_of(Rambo::RSpec::HelperFile)
          .to receive(:initialize)
          .with(hash_including(
            :template_path => File.join(RAMBO_ROOT, "rambo/rspec/templates/rambo_helper_file_template.erb"),
            :file_path     => "spec/rambo_helper.rb",
            :options       => { rails: true }
          ))
        expect_any_instance_of(Rambo::RSpec::HelperFile).to receive(:generate)
      end

      subject.generate_rambo_helper!
    end
  end

  describe "#generate_spec_file!" do
    before(:each) do
      allow(File).to receive(:open)
    end

    it "generates foobar_spec.rb" do
      allow_any_instance_of(Rambo::RSpec::SpecFile).to receive(:render).and_return("foo")
      expect(File).to receive(:write).with("spec/contract/foobar_spec.rb", "foo")
      subject.generate_spec_file!
    end
  end

  describe "#generate_matcher_dir!" do
    it "creates a spec/support/matchers directory" do
      expect(FileUtils).to receive(:mkdir_p).with("spec/support/matchers")
      subject.generate_matcher_dir!
    end
  end

  describe "#generate_matchers!" do
    it "adds a matcher file" do
      aggregate_failures do
        expect_any_instance_of(Rambo::RSpec::HelperFile)
          .to receive(:initialize)
          .with(hash_including(
            :template_path => File.join(RAMBO_ROOT, "rambo/rspec/templates/matcher_file_template.erb"),
            :file_path     => "spec/support/matchers/rambo_matchers.rb"
          ))
        expect_any_instance_of(Rambo::RSpec::HelperFile).to receive(:generate)
      end

      subject.generate_matchers!
    end
  end

  describe "#generate_examples!" do
    it "creates the directory" do
      expect(FileUtils).to receive(:mkdir_p).with("spec/support/examples")
      subject.generate_examples!
    end
  end
end
