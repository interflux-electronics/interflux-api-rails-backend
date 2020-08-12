
# SETUP LOCAL (MAC)

brew update
brew install rbenv ruby-build

# Someone suggest to then add `rbenv` to path, but no need...

set --universal fish_user_paths $fish_user_paths ~/.rbenv/shims

# Instead:

rbenv init

# Suggest to add the following to Fish config:

atom ~/.config/fish/config.fish
status --is-interactive; and source (rbenv init -|psub)

#  Install and start Postgres

brew install postgresql
brew services start postgresql

# Clone repo

git clone git@github.com:janwerkhoven/api.interflux.com.git
cd api.interflux.com

# Install Ruby and all gems

rbenv install -s
rbenv rehash
gem install bundler
gem install rails
bin/bundle install

# Fire up local database

bin/rails db:drop;
bin/rails db:create
bin/rails db:migrate
bin/rails db:environment:set RAILS_ENV=development;
bin/rails db:create;
bin/rails db:migrate;

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

# Create authenticated user

bin/rails c
p = Person.create(first_name:'Jan', last_name:'Werkhoven')
User.create(email:'j.werkhoven@interflux.com', password: '12345678', person_id: p.id)

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
