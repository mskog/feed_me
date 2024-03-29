ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec-given'
require 'database_cleaner'
require 'webmock/rspec'

# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  require 'simplecov'
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
  SimpleCov.start do
    add_filter "/spec/"
  end
end

WebMock.disable_net_connect!

load File.join(Rails.root, 'Rakefile')

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.infer_spec_type_from_file_location!

  config.order = 'random'

  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |c|
     c.syntax = [:expect]
   end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each do |example|
    DatabaseCleaner.start unless example.metadata[:nodb]
  end

  config.after(:each) do |example|
    DatabaseCleaner.clean unless example.metadata[:nodb]
  end

   config.before(:all) do
     FactoryGirl.reload
   end
end
