RSpec::Matchers.define :match_schema do |schema|
  match do |response|
    JSON::Validator.validate!(schema, response, strict: true)
  end
end
