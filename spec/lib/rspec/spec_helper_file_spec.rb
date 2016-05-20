RSpec.describe Rambo::RSpec::SpecHelperFile do

  describe "#generate" do
    let(:rambo_helper_path){
      File.join(SPEC_DIR_ROOT, "../", described_class::RAMBO_HELPER_PATH)
    }

    let(:delete_rambo_helper){
      File.delete(rambo_helper_path) if File.exist? rambo_helper_path
    }

    context "when there is no rambo helper file" do
      before { delete_rambo_helper }

      it "creates the file" do
        subject.generate
        expect(File.exist?(rambo_helper_path)).to eq true
      end
    end

    context "when there is a rambo helper file" do
      it "creates the file" do
        File.open(rambo_helper_path, "w+")
        expect(subject).to_not receive(:write_template)
        subject.generate
      end
    end

    after { delete_rambo_helper }
  end
end
