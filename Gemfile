source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'

gem 'devise'
gem 'friendly_id', '~> 5.1'
gem 'jbuilder', '~> 2.7'
gem 'sqlite3', '~> 1.4'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.0'
gem 'rubocop-rails', require: false




# gem 'bcrypt', '~> 3.1.7'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem 'simplecov', require: false
  gem 'factory_bot_rails'

end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do 
    gem 'capybara'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
