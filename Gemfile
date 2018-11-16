source 'https://rubygems.org'

ruby '2.4.1'

# Ruby on Rails framework
gem 'rails', '~> 5.1.6'

# Puma app server
gem 'puma', '~> 3.7'

# Postgress database
gem 'pg'

# For handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', require: 'rack/cors'

# For converting all incoming JSON to snake_case and outgoing JSON to dashes
gem 'olive_branch'

# For JSON API compliant serialisers
gem 'fast_jsonapi'

# For coloured printing in byebug and console `ap`
gem 'awesome_print'

# For halting the code and debugging `byebug`
gem 'byebug', '~> 10.0', groups: %i[development test]

# For dumping database data into a YAML file
gem 'yaml_db'

group :development do
  # For listening to file changes
  gem 'listen', '>= 3.0.5', '< 3.2'

  # For deploying code to remote servers
  gem 'mina', '~> 1.2', require: false
  gem 'mina-puma', require: false

  # For Ruby syntax formatting
  gem 'rubocop', require: false

  # For annotating models with schemas
  gem 'annotate', require: false
end

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# For mocking and asserting HTTP requests in tests
# gem 'webmock', '~> 3.4', group: :test
