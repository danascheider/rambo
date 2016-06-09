RSpec.describe Rambo::DocumentGenerator do
  let(:valid_file) { File.expand_path('../../support/foobar.raml', __FILE__) }
  let(:options) { { rails: true } }
  let(:generator) { Rambo::DocumentGenerator.new(valid_file, options) }

  before(:each) do
    allow_any_instance_of(Rambo::DocumentGenerator).to receive(:extract_raml)
  end

  describe "#generate_spec_dir!" do
    it "generates the spec/contract directory" do
      expect(FileUtils).to receive(:mkdir_p).with("spec/contract/output")
      generator.generate_spec_dir!
    end
  end

  describe "#generate_rambo_helper!" do
    it "generates the rambo_helper file" do
      aggregate_failures do
        expect_any_instance_of(Rambo::RSpec::HelperFile)
          .to receive(:initialize)
          .with({
            :template_path => File.expand_path("lib/rspec/templates/rambo_helper_file_template.erb"),
            :file_path     => "spec/rambo_helper.rb"
          })
        expect_any_instance_of(Rambo::RSpec::HelperFile).to receive(:generate)
      end

      generator.generate_rambo_helper!
    end
  end

  describe "#generate_spec_file!" do
    before(:each) do
      allow(File).to receive(:open)
    end

    it "generates foobar_spec.rb" do
      allow_any_instance_of(Rambo::RSpec::SpecFile).to receive(:render).and_return("foo")
      expect(File).to receive(:write).with("spec/contract/foobar_spec.rb", "foo")
      generator.generate_spec_file!
    end
  end

  describe "#generate_matcher_dir!" do
    it "creates a spec/support/matchers directory" do
      expect(FileUtils).to receive(:mkdir_p).with("spec/support/matchers")
      generator.generate_matcher_dir!
    end
  end

  describe "#generate_matchers!" do
    it "adds a matcher file" do
      aggregate_failures do
        expect_any_instance_of(Rambo::RSpec::HelperFile)
          .to receive(:initialize)
          .with(
            template_path: File.expand_path("lib/rspec/templates/matcher_file_template.erb"),
            file_path: "spec/support/matchers/rambo_matchers.rb"
          )
        expect_any_instance_of(Rambo::RSpec::HelperFile).to receive(:generate)
      end

      generator.generate_matchers!
    end
  end

  describe "#generate_examples!" do
    it "creates the directory" do
      expect(FileUtils).to receive(:mkdir_p).with("spec/support/examples")
      generator.generate_examples!
    end
  end
end
