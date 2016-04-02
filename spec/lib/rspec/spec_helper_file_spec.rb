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
      let(:contents) { "require 'rspec'\n" }

      before(:each) do
        allow(File).to receive(:read).with('spec/spec_helper.rb').and_return(contents)
      end

      it 'ensures json is required' do
        expect(subject.render).to match(/require "json"/)
      end

      it 'ensures rack/test is required' do
        expect(subject.render).to match(/require "rack\/test"/)
      end
    end
  end
end
