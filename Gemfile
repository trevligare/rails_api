# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.5.1'

gem 'rails', '~> 5.2.3'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'jbuilder', '~> 2.9'
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'ffaker'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.4'
end
