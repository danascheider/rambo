RSpec.describe Rambo::Rake::Task do
  describe "#initialize" do
    it "defines the task" do
      expect_any_instance_of(Rambo::Rake::Task)
        .to receive(:define_task)
      described_class.new
    end
  end

  describe "rambo task" do
    before(:each) do
      Rambo::Rake::Task.new
    end

    it "calls generate_contract_tests!" do
      expect(Rambo).to receive(:generate_contract_tests!)
      Rake::Task[:rambo].invoke
    end
  end
end
