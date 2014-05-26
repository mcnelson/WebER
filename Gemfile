source 'https://rubygems.org'

gem 'rails', '3.2.18'           # Where it all begins

gem 'therubyracer'              # Exec JS
gem 'less-rails'                # LESS Stylesheets
gem 'pg'                        # PostgreSQL
gem 'twitter-bootstrap-rails'   # Twitter Bootstrap
gem 'slim-rails'                # Slim
gem 'simple_form'               # SimpleForm (form processing)
gem 'nested_form'               # Form controls for has many relationships
gem "paperclip"                 # Paperclip (Attach images to models)
gem 'kaminari'                  # Pagination
gem 'later_dude', '>= 0.3.1'    # Calendar rendering
gem 'bcrypt-ruby', '~> 3.0.0'   # BCrypt for has_secure_password

group :assets do
  gem 'jquery-rails'            # JQuery
  gem 'sass-rails'              # Syntactically Awesome Stylesheets
  gem 'coffee-rails'            # CoffeeScript
  gem 'uglifier'                # JS Compression
end

group :development do
  gem 'zeus'                    # Fast startup
  gem 'rspec-rails'             # Specs
  gem 'rails-erd'               # Model diagramer
  gem 'pry'                     # Debugging
  gem 'pry-rails'               # Debugging
  gem 'pry-byebug'              # Debugging
end

group :test do
  gem 'factory_girl'            # Specs
  gem 'factory_girl_rails'      # Specs
  gem 'turn', '< 0.8.3'         # Alternative runners for MiniTest
end

group :production do
  gem 'passenger'               # Apache deployment
end
