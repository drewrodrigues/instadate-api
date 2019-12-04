source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'annotate', '~> 2.6'
gem 'aws-sdk-s3', require: false
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'city-state', '~> 0.0.13'
gem "geocoder", "~> 1.5"
gem 'jbuilder', '~> 2.7'
gem 'pg', '~> 1.1'
gem 'puma', '~> 3.11'
gem 'rack-cors'
gem 'rails', '~> 6.0.0'
gem 'valid_email2', '~> 3.1'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'factory_bot_rails', '~> 5.1'
  gem 'pry'
  gem 'rspec-rails', '~> 3.9'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 4.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
