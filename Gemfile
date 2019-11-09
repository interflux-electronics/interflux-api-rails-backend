source 'https://rubygems.org'

# Which version of Ruby to use (keep in sync with .ruby-version)
ruby '2.6.5'

# Ruby on Rails framework
gem 'rails', '~> 5.1.6'

# Puma app server
gem 'puma', '~> 3.7'

# Postgress database
gem 'pg'

# For handling Cross-Origin Resource Sharing (CORS)
gem 'rack-cors', require: 'rack/cors'

# For loading in environment variables
gem 'dotenv-rails'

# For converting all incoming JSON to snake_case and outgoing JSON to dashes
gem 'olive_branch'

# For JSON API compliant serialisers
gem 'fast_jsonapi'

# For token based authentication, specifically Json Web Token (JWT)
gem 'jwt'

# For enabling ActiveModel has_secure_password, effectively hiding user passwords from the database
gem 'bcrypt', '~> 3.1.7'

# For coloured printing in byebug and console `ap`
gem 'awesome_print'

# For halting the code and debugging `byebug`
gem 'byebug', '~> 10.0', groups: %i[development test]

# For seeding the database with modular control and dependencies
gem 'seedbank'

# For dumping database data into a YAML file (great for maintenance backups)
gem 'yaml_db'

group :development do
  # For listening to file changes
  gem 'listen', '>= 3.0.5', '< 3.2'

  # For Ruby syntax formatting
  gem 'rubocop', require: false

  # For annotating models with schemas
  gem 'annotate', require: false
end

# https://www.skylight.io/
# gem "skylight"
