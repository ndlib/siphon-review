source 'https://rubygems.org'

gem 'bigdecimal'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', "~> 4.2.0"


#gem 'hesburgh_assets', :git => 'git@git.library.nd.edu:assets'
gem "hesburgh_infrastructure", github: "ndlib/hesburgh_infrastructure"

gem "therubyracer"


gem 'american_date'

# db backends
gem 'mysql2'

# authentication
gem 'rubycas-client'
gem 'devise'
# gem 'devise_cas_authenticatable'
gem 'omniauth-oktaoauth'

# LDAP lookups
gem 'net-ldap'

# form generation
gem 'simple_form'
gem 'nested_form'

gem "paperclip"

#gem 'paper_trail'

gem "state_machine"


# Deploy with Capistrano
gem 'capistrano'


gem 'exception_notification', "~> 4.0.0"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# For Errbit
gem "airbrake"

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jquery-datatables-rails', '1.11.2'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'virtus'

gem 'nokogiri'

gem 'addressable'

gem 'rb-readline'

gem "whenever", :require => false

# used to fix broken osx builds.
gem "libv8", "3.16.14.19"

gem "faraday"
gem "faraday_middleware"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :test do
  gem 'json_spec'
  gem 'capybara'
  gem 'launchy', '~> 2.1.0'
  gem 'faker'
  gem 'selenium-webdriver'

  gem 'growl'
  gem 'growl-rspec'
  gem 'rb-fsevent'
    gem 'database_cleaner'
  gem 'factory_girl', "~> 2.6.0"
  gem 'factory_girl_rails', "~> 1.7.0"
  gem 'spork-rails', :github => 'sporkrb/spork-rails'

  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'guard-coffeescript'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-spork'
  gem 'guard-shell'

  gem 'webmock'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails' # Debugger replacements.  Use "binding.pry" where you would use "debugger"
end


# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
  # gem 'debugger', group: [:development, :test]
