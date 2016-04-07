source 'https://rubygems.org'

# heroku requires standard output and static assets
gem 'rails_12factor', group: :production

gem 'puma'
gem 'foreman'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

# Use potgres as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'devise'

#Api gems
gem 'active_model_serializers'

#cloud storage
gem 'paperclip', '~> 4.3'
gem 'aws-sdk', '< 2.0'

# environment variable management
gem 'figaro'

# simple forms (also needed for sabisu)
gem 'simple_form', '~> 3.1.0'

gem 'workflow'

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do

  gem 'factory_girl_rails'
  gem 'ffaker'

  # gems for sabisu - rest api tester
  gem 'sabisu_rails', github: "IcaliaLabs/sabisu-rails"
  gem 'compass-rails', '~> 2.0.0'
  gem 'furatto', '~> 1.3.7'
  gem 'font-awesome-rails', '~> 4.3.0.0'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-rails', '~> 3.1'
end
