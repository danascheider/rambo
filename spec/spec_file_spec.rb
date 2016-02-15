require 'spec_helper'

describe Rambo::SpecFile do 
  let(:raml_file) { File.expand_path('../support/foobar.raml', __FILE__) }
  let(:raml) { Raml::Parser.parse(File.open(raml_file, 'r+', &:read)) }
  let(:spec_file) { Rambo::SpecFile.new(raml: raml) }

  describe '#initialize' do 
    it 'assigns @raml' do 
      expect(spec_file.raml).to eql raml
    end
  end

  describe '#template' do 
    it 'is a string' do 
      expect(spec_file.template.is_a?(String)).to be true
    end
  end

  describe '#render' do 
    it 'interpolates the correct values' do 
      expect(spec_file.render).to include('e-BookMobile API')
    end
  end
end