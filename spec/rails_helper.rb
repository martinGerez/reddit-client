require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/lib/'
  add_filter '/log/'
  add_filter '/tmp/'
  add_filter '/vendor/'
  add_filter '/app/channels/'
  add_filter '/app/mailers/'
  add_filter '/gems/'
end
require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'database_cleaner'
require 'shoulda/matchers'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods

    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.clean_with :truncation
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
