RSpec.describe Rambo::RamlModels::SecurityScheme do
  let(:raml_file) { File.join(SPEC_DIR_ROOT, "support/secured_api.raml") }
  let(:raml)      { Raml::Parser.parse_file(raml_file).security_schemes.auth_header }
end
