RSpec.describe Rambo::Rake::Task do
  describe "#initialize" do
    context "when there is a .rambo.yml" do
      it "reads options from .rambo.yml" do
        expect(File).to receive(:read).with(File.expand_path(".rambo.yml"))
        described_class.new
      end
    end

    context "when there is no .rambo.yml" do
      it "doesn't raise an error" do
        #
      end

      it "uses default options" do
        #
      end
    end
  end
end
