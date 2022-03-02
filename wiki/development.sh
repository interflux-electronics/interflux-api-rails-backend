
# SETUP LOCAL (MAC)

brew update
brew install rbenv ruby-build

# As long brew exists in the PATH, then rbenv will exist as well and all next
# steps are not necessary?

# eval "$(/opt/homebrew/bin/brew shellenv)"
# echo "$PATH"

# Someone suggest to then add `rbenv` to path, but no need...

# set --universal fish_user_paths $fish_user_paths ~/.rbenv/shims

# Instead:

# rbenv init

# Suggest to add the following to Fish config:

# atom ~/.config/fish/config.fish
# status --is-interactive; and source (rbenv init -|psub)

#  Install and start Postgres

brew install postgresql
brew services start postgresql

# Clone repo

git clone git@github.com:janwerkhoven/api.interflux.com.git
cd api.interflux.com

# Install Ruby

rbenv install -s
rbenv rehash

# Before you can install gems you may need to claim ownership over these directories:
# TODO: find bettter way
sudo chown -R jw /Library/Ruby/Gems/
sudo chown -R jw /usr/local/bin/

# Install gems
gem install bundler
gem install rails
bin/bundle install

# Fire up local database

bin/rails db:drop;
bin/rails db:create
bin/rails db:migrate

# Serve Rails

bin/rails s

# ---------

# COMMON COMMANDS

# Open Rails console

bin/rails c

# Generate common route-controller-model-serialiser-test scaffold

bin/rails generate custom_scaffold products --version=v1 --scope=public
bin/rails generate custom_scaffold product_documents --version=v1 --scope=admin

# Seed database

bin/rails db:seed
bin/rails db:seed:documents
bin/rails db:seed:products

# Seed database with fixtures (outdated)

bin/rails db:fixtures:load FIXTURES=articles

# Drop database and start over

bin/rails db:environment:set RAILS_ENV=development;
bin/rails db:drop;
bin/rails db:create;
bin/rails db:migrate;
bin/rails db:seed

# Roll back a migration:

bin/rails db:rollback STEP=1

# Test user login

curl \
-X POST \
-H "Content-Type: application/vnd.api+json" \
-d '{ "email": "j.werkhoven@interflux.com", "password": 12345678 }' \
http://localhost:3000/v1/admin/auth/login

# Add auth token

curl \
-X GET \
-H "Content-Type: application/vnd.api+json" \
-H "Authorization: $token" \
http://localhost:3000/v1/admin/leads

# Sanity check:

curl \
-X GET \
-H "Content-Type: application/vnd.api+json" \
http://localhost:3000/sanity-check

# ---------

# USERS

# First set the development environment flag
export RAILS_ENV=development

# Create user
bin/rails user:create email=foo@bar password=1234 first_name=John last_name=Doe

# Update password
bin/rails user:password email=foo@bar password=12345

# Delete user
bin/rails user:delete email=foo@bar
