source 'https://rubygems.org'

gem 'rails', '3.2.8'

# JQuery
gem 'jquery-rails'

# Twitter Bootstrap
gem 'twitter-bootstrap-rails'

# PostgreSQL
gem 'pg'

# Slim
gem 'slim-rails'

# BCrypt for has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# SimpleForm (form processing)
gem 'simple_form'

# Paperclip (Attach images to models)
gem "paperclip", "~> 3.0"

# Pagination
gem 'kaminari'

# Autocomplete, use Slash4's fork to support multiple column search (https://github.com/crowdint/rails3-jquery-autocomplete/pull/95)
# Actually, screw this gem...
# gem 'rails3-jquery-autocomplete', git: "git://github.com/slash4/rails3-jquery-autocomplete.git"

# Calendar rendering
gem 'later_dude', '>= 0.3.1' # 0.3.0 was broken!

# Datepicker rendering
gem 'jquery_datepicker'

# Specs
gem 'factory_girl'
gem 'factory_girl_rails'

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

group :test do
  # RSpec (testing)
  gem 'rspec-rails'

  # Alternative runners for MiniTest
  gem 'turn', '< 0.8.3'
end

group :production do

  # Apache deployment
  gem 'passenger'
end
