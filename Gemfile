source 'https://rubygems.org'

# Read the ruby version for Heroku
File.open(File.expand_path('../.ruby-version', __FILE__), 'r') do |f|
  ruby f.read.strip
end

gem 'active_model_serializers', '0.8.3'
gem 'devise'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'rack-cors'
gem 'rails', '4.2.1'
gem 'rails-api'
gem 'rollbar', '~> 1.5.0'
gem 'wisper'

# For generating fake records in a staging environment
gem 'factory_girl_rails', '~> 4.0'
gem 'faker'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'spring'
end

group :test do
  gem 'codecov', require: false
  gem 'database_cleaner'
  gem 'json-schema'
  gem 'json_spec'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :production do
  # Adds Heroku-specific configuration for production environments.
  gem 'rails_12factor'
end
