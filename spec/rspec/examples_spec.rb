require "spec_helper"

describe Rambo::RSpec::Examples do
  let(:raml_file) { File.expand_path("../../support/foobar.raml", __FILE__) }
  let(:raml) { Raml::Parser.parse(File.read(raml_file)) }

  subject { Rambo::RSpec::Examples.new(raml: raml) }

  describe "generate!" do
    it "calls render on each group" do
      expect_any_instance_of(Rambo::RSpec::ExampleGroup).to receive(:render)
      subject.generate!
    end
  end
end
