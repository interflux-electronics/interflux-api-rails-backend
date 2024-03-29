source 'https://rubygems.org'

# Which version of Ruby to use (keep in sync with .ruby-version)
ruby '3.0.0'

# Ruby on Rails framework
gem 'rails'

# Puma app server
gem 'puma', '4.3.6'

# Postgress database
gem 'pg'

# For handling Cross-Origin Resource Sharing (CORS)
gem 'rack-cors', require: 'rack/cors'

# For loading in environment variables
gem 'dotenv-rails'

# For converting all incoming JSON to snake_case and outgoing JSON to dashes
gem 'olive_branch'

# For JSON API compliant serialisers
gem 'jsonapi-serializer'

# For token based authentication, specifically Json Web Token (JWT)
gem 'jwt'

# For enabling ActiveModel has_secure_password, effectively hiding user passwords from the database
gem 'bcrypt'

# For coloured printing in byebug and console `ap`
gem 'awesome_print'

# For halting the code and debugging `byebug`
gem 'byebug', groups: %i[development test]

# For seeding the database with modular control and dependencies
gem 'seedbank'

# For dumping database data into a YAML file (great for maintenance backups)
gem 'yaml_db'

# So we can upload files to Digital Ocean Spaces (S3-compatible)
gem 'aws-sdk-s3'

# For HTTP requests (native Rails does this terribly...)
gem 'faraday'

# For catching N+1 queries
gem 'bullet', groups: %i[development test]

# For listening to file changes
gem 'listen', groups: %i[development]

# For Ruby syntax formatting
gem 'rubocop', groups: %i[development], require: false
gem 'rubocop-rails', groups: %i[development]

# For testing (out-of-the-box with Rails 5)
gem 'minitest', groups: %i[test]

# For annotating models and fixtures with schema info.
gem 'annotate', groups: %i[development]