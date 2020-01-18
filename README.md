# Rails - api.interflux.com

This Rails app is the back-end for three Ember apps:

- [www.interflux.com](https://www.interflux.com)
- [lmpa.interflux.com](https://lmpa.interflux.com)
- [admin.interflux.com](https://admin.interflux.com)

It is hosted on:

- [api.interflux.com](https://api.interflux.com)

Build status:

| `master`                                                                                                                                                                  | `production`                                                                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![Build status](https://badge.buildkite.com/feec3c1bb9d5fa10832931944a2af6a98fa4d2225c3b002045.svg?branch=master)](https://buildkite.com/nabu/api-dot-interflux-dot-com) | [![Build status](https://badge.buildkite.com/feec3c1bb9d5fa10832931944a2af6a98fa4d2225c3b002045.svg?branch=production)](https://buildkite.com/nabu/api-dot-interflux-dot-com) |

## Development

Setup on Mac:

```
brew update
brew install rbenv ruby-build
```

Someone suggest to then add `rbenv` to path, but no need...

```
set --universal fish_user_paths $fish_user_paths ~/.rbenv/shims
```

Instead:

```
rbenv init
```

Suggest to add the following to Fish config:

```
atom ~/.config/fish/config.fish
status --is-interactive; and source (rbenv init -|psub)
```
```
brew install postgresql
brew services start postgresql
```
```
git clone git@github.com:janwerkhoven/api.interflux.com.git
cd api.interflux.com
rbenv install -s
rbenv rehash
gem install bundler
gem install rails
bin/bundle install
bin/rails db:drop;
bin/rails db:create
bin/rails db:migrate
bin/rails db:environment:set RAILS_ENV=development;
bin/rails db:create;
bin/rails db:migrate;
bin/rails db:fixtures:load;
```

Fire up Rails:

```
bin/rails s
```

Access console:

```
bin/rails c
```

Seed database with fixtures:

```
bin/rails db:fixtures:load FIXTURES=articles
```

Generate custom scaffold for new resource:

```
bin/rails generate custom_scaffold related_things --version=v1 --scope=admin
```

Drop database and start over:

```
bin/rails db:environment:set RAILS_ENV=development;
bin/rails db:drop;
bin/rails db:create;
bin/rails db:migrate;
bin/rails db:seed
```

Create user:

```
bin/rails c
p = Person.create(first_name:'Jan', last_name:'Werkhoven')
User.create(email:'j.werkhoven@interflux.com', password: '12345678', person_id: p.id)
```

Test login:

```
curl \
-X POST \
-H "Content-Type: application/vnd.api+json" \
-d '{ "email": "j.werkhoven@interflux.com", "password": 12345678 }' \
http://localhost:3000/v1/admin/auth/login

set token TOKEN

curl \
-X GET \
-H "Content-Type: application/vnd.api+json" \
-H "Authorization: $token" \
http://localhost:3000/v1/admin/leads
```

Roll back a migration:

```
bin/rails db:rollback STEP=1
```

Sanity check:

```
curl \
-X GET \
-H "Content-Type: application/vnd.api+json" \
http://localhost:3000/sanity-check
```

## Production

Manual deploy to production (from local):

```
./deploy.sh
```

Control Puma:

```
bin/pumactl -F config/puma/production.rb -T '12345' start
bin/pumactl -F config/puma/production.rb -T '12345' stop
bin/pumactl -F config/puma/production.rb -T '12345' phased-restart
```

Access production console:

```
bin/rails console production
```

Seed production database with fixtures:

```
export RAILS_ENV=production
bin/rails db:seed
```

Backup and drop production database:

```
env RAILS_ENV=production rake db:data:dump
jw@server-singapore.interflux.com:/var/www/api.interflux.com/builds/feature/authentication/cd977ad/db/data.yml .
```

```
bin/rails db:data:dump
bin/pumactl -F config/puma/production.rb -T '12345' stop
export RAILS_ENV=production;
export DISABLE_DATABASE_ENVIRONMENT_CHECK=1;
bin/rails db:drop
```

Health check:

```
curl https://api.interflux.com/status
```

This should return you a 200 with JSON payload. The API is down if it doesn't!

## Testing

Test all:

```
bin/rails t
bin/rails test
bin/rails test --verbose
```

Test specific folder:

```
bin/rails test test/integration/v1/public/*
```

Test specific file:

```
bin/rails test test/integration/v1/public/products_integration_test.rb
```

Test specific test (add line number):

```
bin/rails test test/integration/v1/public/products_integration_test.rb:22
```

## Trouble shooting

`PG::ConnectionBad`

Check if Postgress is running.

`EADDRINUSE`

Port 3000 is already taken by another process. This is most likely a rogue Puma
process that wasn't stopped properly. Find the process ID (pid) by running:

```
sudo lsof -iTCP -sTCP:LISTEN -P
```

Then kill the one listening to port 3000:

```
kill -9 [pid]
```
