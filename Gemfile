source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'nokogiri'
gem 'json'
gem 'bootstrap-sass'

gem 'rails_12factor', group: :production

gem 'faraday'

# Pagination
gem 'kaminari'

gem "therubyracer"

# Deployment related
gem 'capistrano', '~> 2.15.5'
gem 'rvm-capistrano', '~> 1.3.3'
gem "net-ssh", '=2.7.0'

group :production do
  # Use postgre as the database for Active Record
  gem 'pg'
end

group :development, :test do
  # Use mysql as the database for Active Record
  gem 'mysql2'
end

group :development do
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
end
