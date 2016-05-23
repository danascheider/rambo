RSpec.describe Rambo::RSpec::RamboHelperFile do

  describe "#generate" do
    let(:rambo_helper_path){
      File.join(SPEC_DIR_ROOT, "../", described_class::RAMBO_HELPER_PATH)
    }

    let(:delete_rambo_helper){
      File.delete(rambo_helper_path) if File.exist? rambo_helper_path
    }

    before { delete_rambo_helper }
    after  { delete_rambo_helper }

    context "when there is no rambo helper file" do
      it "creates the file" do
        subject.generate
        expect(File.exist?(rambo_helper_path)).to eq true
      end
    end

    context "when there is a rambo helper file" do
      it "does not create the file" do
        subject.generate
        expect(subject).to_not receive(:write_template)
        subject.generate
      end
    end
  end
end
