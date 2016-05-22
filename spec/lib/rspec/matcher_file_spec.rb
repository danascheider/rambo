RSpec.describe Rambo::RSpec::MatcherFile do
  let(:matchers_path) {
    File.expand_path("spec/support/matchers/rambo_matchers.rb")
  }

  before(:each) do
    FileUtils.mkdir_p("spec/support/matchers")
  end

  after(:each) do
    File.delete(matchers_path) if File.exist? matchers_path
    FileUtils.rmdir(File.expand_path("spec/support/matchers")) rescue nil # only delete dir if empty
    FileUtils.rmdir(File.expand_path("spec/support")) rescue nil
  end

  describe "#generate" do
    it "creates the file" do
      subject.generate
      expect(File.exist? matchers_path).to be true
    end
  end
end
