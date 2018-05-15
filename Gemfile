# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"

gem "puma", "~> 3.11"
gem "rails", "~> 5.2.0"
gem "sass-rails", "~> 5.0"
gem "sqlite3"
gem "uglifier", ">= 1.3.0"

gem "coffee-rails", "~> 4.2"
gem "faraday"
gem "faraday-http-cache"
gem "faraday-log-subscriber"
gem "faraday_middleware"
gem "jbuilder", "~> 2.5"
gem "omniauth-oauth2"
gem "pg"
gem "pry-rails"
gem "turbolinks", "~> 5"

# gem "eve_online", path: "../eve_online"
gem "sidekiq"

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem "guard"
  gem "guard-process"
  gem "guard-minitest"
  gem "guard-sidekiq"
end

group :test do
  gem "capybara", ">= 2.15", "< 4.0"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
  gem "rails-controller-testing"
end
