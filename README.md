# Interflux API

This is the Rails API for Interflux Electronics.

https://api.interflux.com

Which powers:

https://www.interflux.com  
https://lmpa.interflux.com  
https://admin.interflux.com

## Gems

```
gem install bundle;
bundle install
```

## Migrations

#### Local

```
rails db:environment:set RAILS_ENV=development;
rails db:drop;
rails db:create;
rails db:migrate;
rails db:migrate RAILS_ENV=test;
rails db:fixtures:load
annotate;
```

#### Production

Clean wipe and restart:

```
export RAILS_ENV=production;
export DISABLE_DATABASE_ENVIRONMENT_CHECK=1;
rake db:drop;
rake db:create;
rake db:migrate;
rake db:fixtures:load
```

On running database:

```
export RAILS_ENV=production;
rake db:migrate;
```

## Seeding

```
rake db:fixtures:load
rake db:fixtures:load FIXTURES=product_categories
rake db:fixtures:load FIXTURES=product_categories,products,users
```

Source: http://brandonhilkert.com/blog/using-rails-fixtures-to-seed-a-database/

## Console

#### Local

```
rails c
ap [something]
pp [something]
```

#### Production

```
export RAILS_ENV=production;
rails c
pp [something]
```

#### Authentication

Create test user:

```
export RAILS_ENV=production;
rails c
User.create!(email: 'admin@example.com' , password: 'password' , password_confirmation: 'password')
```

Then from your local and with Puma running:

```
curl -X POST https://api.interflux.com/admin/login -d '{"email":"admin@interflux.com","password":"password"}'
```

How to auth:

```
curl -H "Content-Type: application/json" -X POST -d '{"email":"example@mail.com","password":"123123123"}' http://localhost:3000/authenticate
curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDc0NDMwMTB9.xPlcqij4Gpi9wnPvgmI8rdVP23b7Zw1yBD22uu8nApI" http://localhost:3000/admin/products
http GET http://localhost:3000/admin/products Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDc0NDMwMTB9.xPlcqij4Gpi9wnPvgmI8rdVP23b7Zw1yBD22uu8nApI
```

Update password

```
User.create!(email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123')
User.where(email: 'jw@interflux.com').first.update!(password: 'password123' , password_confirmation: 'password123')
```

## Deploys

Locally

```
git push server production
```

Remote

```
bundle install;
bundle exec pumactl -S ./shared/pids/puma.state stop;
export RAILS_ENV=production;
rake db:migrate;
bundle exec puma
```

```
bundle exec pumactl -S ./shared/pids/puma.state stop;
bundle exec puma
```

## Puma

To start:

```
bundle exec puma
```

To stop:

```
bundle exec pumactl -S /var/www/api.interflux.com/shared/pids/puma.state stop
```

Finding and stopping the puma pid manually:
http://ruby-journal.com/how-to-setup-rails-app-with-puma-and-nginx/

## Rails

To kill running Rails process:

```
lsof -wni tcp:3000;
```

Copy the PID then ...

```
kill -9 [the PID]
```

## Errors

To return errors as JSON API compliant errors:  
https://github.com/rails-api/active_model_serializers/issues/983

## Testing

```
rails test
rails test test/integration/admin
rails test test/integration/public
```
