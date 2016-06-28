RSpec.describe Rambo::RamlModels::SecurityScheme do
  let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/secured_api.raml") }
  let(:raml)      { Raml::Parser.parse_file(raml_file).security_schemes.first }

  subject { described_class.new(raml) }

  it { is_expected.to respond_to :title }
end
