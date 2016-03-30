require 'spec_helper'

describe Rambo::RSpec::SpecHelperFile do
  describe '#initialize' do
    context 'when there is no spec_helper.rb file' do
      it 'generates a file' do
        allow(File).to receive(:exist?).and_return(false)
        expect_any_instance_of(Rambo::RSpec::SpecHelperFile).to receive(:generate!)
        Rambo::RSpec::SpecHelperFile.new
      end
    end
  end
end
