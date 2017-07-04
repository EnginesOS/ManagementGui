source 'https://rubygems.org'

group :development do
  gem 'rubocop', require: false
  gem 'rails_real_favicon'
end
gem "oink"

## Engines System Gems
# Local Docker socket
gem 'net_http_unix'
# git
gem 'git'
# Tree
gem 'rubytree'
# Better JSON - good for handling streams
gem 'yajl-ruby'
# Easy HTTP Rest
gem 'rest-client'

# group :production do
#   # MySQL for production deployment on Engines
#   gem 'mysql2'
# end

##  Engines System GUI Gems
# User registrations
gem 'devise'
# Font Awesome
gem 'font-awesome-rails'
# Twitter Bootstrap
gem 'bootstrap-sass'
# Bootstrap data-confirm popup
# gem 'twitter-bootstrap-rails-confirm'
# Markdown
gem 'redcarpet'
# File attachments
gem 'paperclip'
# Charting
# gem 'chartkick'
gem 'chartjs-ror'
# File upload via AJAX
gem 'remotipart', '~> 1.3.1'
# ANSI code text parsing for javascript
# gem 'ansi_up-rails' --not working with rails 5,
# so manually copied ansi_up-rails js to assets
# Patch OpenURI to optionally allow redirections
gem 'open_uri_redirections'
# Live text search
gem 'listjs-rails'
# ANSI to HTML text converter
gem 'ansi-to-html'

# # Country select
# gem 'country_select'



group :production do
  gem 'redis', '~> 3.0'
end


## Default Rails Gems

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0', '< 5.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster.
# Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or
  # by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in
  # the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
