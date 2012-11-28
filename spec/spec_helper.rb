require 'rubygems'
require 'bundler/setup'

#require 'support/active_record'
require 'active_model'
require 'active_record'
require 'factory_girl'
require 'rspec/rails/extensions/active_record/base'

require 'eel'

dirname = File.dirname(__FILE__)
Dir["#{dirname}/support/**/*.rb"].each { |i| require i.gsub("#{dirname}/", '') }

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