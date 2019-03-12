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

Setup:

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
