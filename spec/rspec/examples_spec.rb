require "spec_helper"

describe Rambo::RSpec::Examples do
  let(:raml_file) { File.expand_path("../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse(File.open(raml_file, "r+", &:read)) }

  subject { Rambo::RSpec::Examples.new(raml: raml) }

  describe "generate!" do
    it "creates example groups" do
      count = raml.resources.size
      expect(Rambo::RSpec::ExampleGroup).to receive(:new).exactly(count).times
      subject.generate!
    end
  end
end
