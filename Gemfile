source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.4'

# gem to load environment variables from .env
gem 'dotenv-rails', '2.2.1'

# Use pg as the database for Active Record
gem 'pg', '0.20.0'

# Use Puma as the app server
gem 'puma', '3.11.2'

# Use SCSS for stylesheets
gem 'sass-rails', '5.0.7'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '4.1.4'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'execjs', '2.7.0'
gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '4.2.2'

# Turbolinks makes navigating your web application faster.
gem 'turbolinks', '5.1.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '2.7.0'

# Gem for API documentation
gem 'apidoco', '1.5.0'

group :development do
  # Call 'binding.pry' in the code to stop execution and get a debugger console
  gem 'pry', '0.11.3'

  # Spring speed up development by keeping application running in the background
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'

  # Ruby static code analyzer
  gem 'rails_best_practices', '1.18.1'
  gem 'rubocop', '0.49.1', require: false
end
