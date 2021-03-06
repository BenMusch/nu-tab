source 'https://rubygems.org'

ruby '2.3.1'

gem 'autoprefixer-rails' # prefix CSS with browser names
gem 'delayed_job_active_record' # Async jobs. TODO: use sidekiq
gem 'rollbar' # error-reporting
gem 'pg' # postgres
gem 'puma' # puma server
gem 'rack-canonical-host' # use a canonical host for the application
gem 'rails', '~> 5.0.0'
gem 'skylight' # application performance monitoring
gem 'sprockets', '>= 3.0.0'
gem 'uglifier'
gem 'graph_matching' # max-weight matching algorithm used to pair

# front-end libraries
gem 'jquery-rails'
gem 'simple_form'
gem 'react_on_rails', '~> 6.9.1'
gem 'sass-rails', '~> 5.0'
gem 'normalize-rails'
gem 'bootstrap', '~> 4.0.0.alpha6'

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
  gem 'annotate'
  gem 'rails_layout'
  gem 'rdoc'
end

group :development, :test do
  gem 'awesome_print'
  gem 'bullet'
  gem 'bundler-audit', '>= 0.5.0', require: false
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'rails_best_practices'
  gem 'simplecov'
  gem 'codeclimate-test-reporter', '~> 1.0.0'
  gem 'faker'
  gem 'refills'
end

group :development, :staging do
  gem 'rack-mini-profiler', require: false
end

group :test do
  gem 'capybara'
  gem 'poltergeist', require: 'capybara/poltergeist'
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'webmock'
end

group :staging, :production do
  gem 'rack-timeout'
end

gem 'mini_racer', platforms: :ruby
