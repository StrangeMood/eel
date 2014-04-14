require 'bundler/setup'

require 'active_support'
require 'active_model'
require 'active_record'
require 'factory_girl'
require 'faker'
require 'rspec/rails/extensions/active_record/base'

require 'support/schema_definition'

require 'eel'

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end
end