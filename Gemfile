source :rubygems

# Specify your gem's dependencies in eel.gemspec
gemspec

gem 'rake'

gem 'rspec'
gem 'sqlite3'
gem 'rspec-rails'
gem 'factory_girl'
gem 'faker'

gem 'arel_predications', path: './arel_predications'

rails = ENV['RAILS'] || '3-2-stable'

git 'git://github.com/rails/rails.git', branch: rails do
  gem 'activesupport'
  gem 'activerecord'
end