
# DEPLOYING TO PRODUCTION

remote/deploy.sh

# ---------

# PUMA

# Control Puma

bin/pumactl -F config/puma/production.rb -T '12345' start
bin/pumactl -F config/puma/production.rb -T '12345' stop
bin/pumactl -F config/puma/production.rb -T '12345' phased-restart

# Access production console

bin/rails console production

# ---------

# DATABASE

# Seed production database

export RAILS_ENV=production
bin/rails db:seed
bin/rails db:seed:products

# Dump and download database

env RAILS_ENV=production rake db:data:dump
jw@server-singapore.interflux.com:/var/www/api.interflux.com/builds/feature/authentication/cd977ad/db/data.yml .

# Drop production database
bin/rails db:data:dump
bin/pumactl -F config/puma/production.rb -T '12345' stop
export RAILS_ENV=production;
export DISABLE_DATABASE_ENVIRONMENT_CHECK=1;
bin/rails db:drop

# ---------

# HEALHT CHECK

curl https://api.interflux.com/sanity-check -H "Content-Type: application/vnd.api+json"