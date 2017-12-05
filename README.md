# README

#### Gems

gem install bundle;
bundle install

#### Migrations

rake db:drop;
rake db:create;
rake db:migrate;
rake db:migrate RAILS_ENV=test;
annotate;
rake db:fixtures:load

#### Seeding

http://brandonhilkert.com/blog/using-rails-fixtures-to-seed-a-database/

rake db:fixtures:load
rake db:fixtures:load FIXTURES=product_groups
rake db:fixtures:load FIXTURES=product_groups,products,users

#### Authentication

# How to auth:
# curl -H "Content-Type: application/json" -X POST -d '{"email":"example@mail.com","password":"123123123"}' http://localhost:3000/authenticate
# curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDc0NDMwMTB9.xPlcqij4Gpi9wnPvgmI8rdVP23b7Zw1yBD22uu8nApI" http://localhost:3000/admin/products
# http GET http://localhost:3000/admin/products Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDc0NDMwMTB9.xPlcqij4Gpi9wnPvgmI8rdVP23b7Zw1yBD22uu8nApI

# Update password
# User.create!(email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123')
# User.where(email: 'jw@interflux.com').first.update!(password: 'password123' , password_confirmation: 'password123')



### Errors

To return errors as JSON API compliant errors:
https://github.com/rails-api/active_model_serializers/issues/983




### Making Puma purr

To start:
1. cd /var/www/api.interflux.com
2. bundle exec puma

To stop:
1. cd /var/www/api.interflux.com
2. bundle exec pumactl -S /var/www/api.interflux.com/shared/pids/puma.state stop

Finding and stopping the puma pid manually:
http://ruby-journal.com/how-to-setup-rails-app-with-puma-and-nginx/
