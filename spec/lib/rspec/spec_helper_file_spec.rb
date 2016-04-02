require 'spec_helper'

describe Rambo::RSpec::SpecHelperFile do

  describe '#render' do
    context 'when there is no spec helper file' do
      it 'returns the template' do
        allow(subject).to receive(:contents).and_return(nil)
        expect(subject).to receive(:template)
        subject.render
      end
    end

    context 'when there is a spec helper file' do
      let(:contents) { 'require "rspec"' }

      before(:each) do
        allow(File).to receive(:read).with('spec/spec_helper.rb').and_return(contents)
      end

      it 'ensures the proper requires are present' do
        expect_any_instance_of(described_class).to receive(:ensure_requires_present!)
        subject.render
      end
    end
  end
end
