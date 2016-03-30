require 'spec_helper'

describe Rambo::RSpec::SpecHelperFile do
  describe '#initialize' do
    context 'when there is no spec_helper.rb file' do
      it 'generates a file' do
        allow(File).to receive(:exist?).and_return(false)
        expect_any_instance_of(described_class).to receive(:generate!)
        described_class.new
      end
    end

    context 'when there is an existing spec_helper.rb file' do
      it 'modifies the existing file' do
        allow(File).to receive(:exist?).and_return(true)
        expect_any_instance_of(described_class).to receive(:modify!)
        described_class.new
      end
    end
  end
end
