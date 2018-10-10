source 'https://rubygems.org'

ruby '2.4.1'

# Ruby on Rails framework
gem 'rails', '~> 5.1.6'

# Puma app server
gem 'puma', '~> 3.7'

# Postgress database
gem 'pg'

# For JSON API compliant serialisers
# https://github.com/Netflix/fast_jsonapi
gem 'fast_jsonapi'

# For handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# https://github.com/cyu/rack-cors
gem 'rack-cors'

# For dumping database data into a YAML file
# https://github.com/yamldb/yaml_dbrai
gem 'yaml_db'

group :development, :test do
  # For coloured printing in byebug and console `ap`
  gem 'awesome_print', require: 'ap'

  # For halting the code and debugging `byebug`
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # For listening to file changes
  gem 'listen', '>= 3.0.5', '< 3.2'

  # For deploying code to remote servers
  gem 'mina', '~> 1.2'

  # For Ruby syntax formatting
  gem 'rubocop', require: false

  # For annotating models with schemas
  gem 'annotate', require: false
end

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
