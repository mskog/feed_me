source 'https://rubygems.org'
ruby '2.2.0'

# Standard Rails gems
gem 'rails', '4.2.6'
gem 'bcrypt', '3.1.11'

# PostgreSQL
gem 'pg', "~> 0.18.4"

# Whitespace remover
gem 'strip_attributes', '~> 1.7'

# Configuration
gem 'dotenv-rails', '~> 2.1'

gem 'virtus', '~> 1.0.5'

# Feeds
gem 'feedjira', '~> 2.0.0'

gem 'clockwork', '~> 2'

gem 'naught', '~> 1.1'

gem 'rollbar', '~> 2.9'

gem 'faraday', '~> 0.9'
gem 'faraday-cookie_jar', '~> 0.0.6'

# Decorating
gem 'draper', '~> 2.1.0'

gem 'therubyracer', '~> 0.12.1', platforms: :ruby
gem 'turbolinks', '~> 2.5.3'

gem 'sinatra', '~> 1.4' # For Fakes

# Background processing
gem 'sidekiq', '< 5'
gem 'sidekiq-limit_fetch'

# Redis store
gem 'redis-rails', '~> 4.0'

# Multi fetch cache
gem 'multi_fetch_fragments', '~> 0.0.17'

# Pagination
gem 'kaminari', '~> 0.16'

# Validations
gem 'validate_url', '~> 1.0', '>= 1.0.2'

# Authentication
gem 'devise', '~> 3.5'
gem 'simple_token_authentication', '~> 1.12'

# Serializers
gem 'active_model_serializers', '~> 0.10.0.rc3'

# HTML parsing
gem 'nokogiri', '~> 1.6'

# CORS
gem 'rack-cors', '~> 0.4.0'


group :development, :test do
  gem 'binding_of_caller', platforms: [:mri_20, :mri_21, :mri_22]
  gem 'guard-rails', '~> 0.7'
  gem 'guard-rspec', '~> 4.6'
  gem 'byebug',  '~> 8.2'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'faker', git: 'https://github.com/joenas/faker'
  gem 'rspec-rails', '~> 3.4'
  gem 'rspec-given', '~> 3.8'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner', '~> 1.5'
  gem 'quiet_assets', '~> 1.1.0'

  gem 'capistrano', '~> 3.4.1'
  gem "capistrano-rails"
  gem 'capistrano-rbenv'
  gem 'capistrano-faster-assets'
  gem 'mascherano'
  gem 'capistrano-db-tasks', git: "https://github.com/sgruhier/capistrano-db-tasks", require: false

  # Spring
  gem 'spring', '1.7.1'
  gem "spring-commands-rspec"

  # Pry
  gem 'pry-rails', '~> 0.3.2'

  gem 'rspec_junit_formatter', '0.2.3'
end

group :test do
  gem 'webmock', '~> 1.24'
  gem 'simplecov', :require => false
end
