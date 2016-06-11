RSpec.describe Rambo::Rake::Task do
  describe "#initialize" do
    it "defines the task" do
      expect_any_instance_of(Rambo::Rake::Task)
        .to receive(:define_task)
      described_class.new
    end
  end
end
