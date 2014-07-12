source 'https://rubygems.org'

gem 'rails', '4.1.1'           # Where it all begins

gem 'therubyracer'              # Exec JS
gem 'less-rails'                # LESS Stylesheets
gem 'pg'                        # PostgreSQL
gem 'twitter-bootstrap-rails'   # Twitter Bootstrap
gem 'simple_form'               # SimpleForm (form processing)
gem 'nested_form'               # Form controls for has many relationships
gem "paperclip", "~> 4.1"       # Paperclip (Attach images to models)
gem 'kaminari'                  # Pagination
gem 'bcrypt-ruby', '~> 3.1.2'   # BCrypt for has_secure_password

gem 'jquery-rails'
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier'
gem 'slim-rails'

group :development do
  #gem "spring"  TODO: Try again later, pretty janky still
  #gem "spring-commands-rspec"
  gem 'rails-erd'               # Model diagramer
  gem 'pry'                     # Debugging
  gem 'pry-rails'               # Debugging
  gem 'pry-byebug'              # Debugging
end

group :test do
  gem 'rspec-rails', '~> 3.0.0.rc1'
  gem 'factory_girl', '~> 4.4.0'
  gem 'factory_girl_rails'      # Specs
  #gem 'turn', '< 0.8.3'         # Alternative runners for MiniTest
  gem 'shoulda-matchers'
  gem 'timecop'
end

group :production do
  gem 'passenger'               # Apache deployment
  gem 'rails_12factor'          # Heroku logging
end
