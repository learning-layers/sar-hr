# Validates JSON responses against a schema
RSpec::Matchers.define :match_schema do |schema|
  match do |body|
    schema_directory = "#{Dir.pwd}/spec/support/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"

    begin
      JSON::Validator.validate!(schema_path, body)
    rescue JSON::Schema::ValidationError => e
      e.message << " in\n\n #{body}"
      raise e
    end
  end

  description do
    "match the JSON schema \"#{expected}\""
  end
end
