
# DEPLOYING TO PRODUCTION

remote/deploy.sh

# ---------

# PUMA

# After server reboot

ssh bot@server.interflux.com -i ~/.ssh/bot@server.interflux.com
cd /var/www/api.interflux.com/builds/production/latest
bin/puma -e production
# which should do the same as:
# bin/puma --environment production
# bin/puma --config config/puma/production.rb

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

# SANITY CHECKS

# From local
curl https://api.interflux.com/sanity-check -H "Content-Type: application/vnd.api+json"

# On server
curl --unix-socket /var/www/api.interflux.com/sockets/puma.sock https://api.interflux.com/sanity-check -H "Content-Type: application/vnd.api+json"

# ---------

# USERS

# First set the production environment flag
export RAILS_ENV=production

# Create user
bin/rails user:create email=foo@bar password=1234 first_name=John last_name=Doe

# Update password
bin/rails user:password email=foo@bar email=12345

# Delete user
bin/rails user:delete email=foo@bar
