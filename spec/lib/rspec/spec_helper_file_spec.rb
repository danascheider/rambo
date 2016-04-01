require 'spec_helper'

describe Rambo::RSpec::SpecHelperFile do

  describe '#render' do
    context 'when there is no spec helper file' do
      it 'calls the template' do
        allow(File).to receive(:exist?).with('spec/spec_helper.rb').and_return(false)
        expect(subject).to receive(:template)
        subject.render
      end
    end
  end

  describe '#generate' do
    it 'generates the spec helper file' do
      #
    end
  end
end
