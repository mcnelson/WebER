source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'jquery-rails'              # JQuery
gem 'twitter-bootstrap-rails'   # Twitter Bootstrap
gem 'pg'                        # PostgreSQL
gem 'slim-rails'                # Slim
gem 'bcrypt-ruby', '~> 3.0.0'   # BCrypt for has_secure_password
gem 'simple_form'               # SimpleForm (form processing)
gem "paperclip", "~> 3.0"       # Paperclip (Attach images to models)
gem 'kaminari'                  # Pagination
gem 'later_dude', '>= 0.3.1'    # Calendar rendering
gem 'jquery_datepicker'         # Datepicker rendering TODO: Not needed likely, remove me
gem 'rspec-rails'               # Specs
gem 'factory_girl'              # Specs
gem 'factory_girl_rails'        # Specs
gem 'turn', '< 0.8.3'           # Alternative runners for MiniTest

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

group :development do

  # Model diagramer
  gem 'rails-erd'

  # Debugging
  gem 'debugger'

  # Thin web server
  gem 'thin'
end

group :production do

  # Apache deployment
  gem 'passenger'
end
