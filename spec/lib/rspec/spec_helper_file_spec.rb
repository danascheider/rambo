RSpec.describe Rambo::RSpec::SpecHelperFile do

  describe "#generate" do
    context "when there is no rambo helper file" do
      it "creates the file" do
        expect(subject).to receive(:write_template)
        subject.generate
      end
    end

    context "when there is a rambo helper file" do
      it "creates the file" do
        allow(subject).to receive(:file_already_exists?).and_return(true)
        expect(subject).to_not receive(:write_template)
        subject.generate
      end
    end
  end
end
