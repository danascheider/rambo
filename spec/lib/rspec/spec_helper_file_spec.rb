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

      context 'when JSON is already required' do
        let(:contents) { "require 'json'\n" }

        it 'doesn\'t require JSON again' do
          expect(subject.render).not_to match(/require "json"/)
        end
      end

      context 'when rack/test is already required' do
        let(:contents) { "require 'rack/test'\n" }

        it 'doesn\'t require rack/test again' do
          expect(subject.render).not_to match(/require "rack\/test"/)
        end
      end
    end
  end
end
