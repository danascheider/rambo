RSpec.describe Rambo::RSpec::HelperFile do
  let(:template_path) {
    File.expand_path("lib/rspec/templates/matcher_file_template.erb")
  }

  let(:file_path) {
    File.expand_path("spec/support/matchers/rambo_matchers.rb")
  }

  subject { described_class.new(template_path: template_path, file_path: file_path) }

  describe "generate" do
    it "writes the file" do
      expect(File).to receive(:write).with(file_path, File.read(template_path))
      subject.generate
    end
  end
end
