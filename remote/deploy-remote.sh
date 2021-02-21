#!/usr/bin/env bash

set -e
set -o pipefail

user=$(whoami)
host=$(cat /etc/hostname)
domain=$1
branch=$2
revision=$3

echo "----------"
echo "User: $user"
echo "Host: $host"
echo "Domain: $domain"
echo "Branch: $branch"
echo "Revision: $revision"
echo "----------"
echo "cd /var/www/$domain"
cd /var/www/$domain
echo "----------"
( set -x; rm -rf builds/$branch/$revision )
echo "----------"
( set -x; mkdir -p builds/$branch/$revision )
echo "----------"
( set -x; git --git-dir=repo fetch )
echo "----------"
( set -x; git --git-dir=repo --work-tree=builds/$branch/$revision checkout $revision -f )
echo "----------"
echo "cd builds/$branch/$revision"
cd builds/$branch/$revision
echo "----------"
( set -x; echo "GIT_BRANCH=$branch" >> .rbenv-vars; echo "GIT_REVISION=$revision" >> .rbenv-vars )
echo "----------"
( set -x; rbenv install -s)
echo "----------"
( set -x; rbenv rehash )
echo "----------"
# (
#   set -x;
#   gem install bundler
# )
echo "----------"
# (
#   set -x;
#   gem install rails
# )
echo "----------"
echo "Install gems"
( set -x; bin/bundle install )
echo "----------"
echo "Migrate"
bin/rails db:migrate
# echo "----------"
# (
#   set -x;
#   ln -nsf /var/www/api.interflux.com/builds/$branch/$revision/var/www/api.interflux.com/builds/$branch/latest
# )
# echo "----------"
# (
#   set -x;
#   # Note, avoid `phased-restart` and `restart` for they have issues
#   bin/pumactl -F config/puma/production.rb -T '12345' stop
#   bin/pumactl -F config/puma/production.rb -T '12345' start
# )
# echo "----------"
# echo "Sanity check on remote"
# (
#   set -x;
#   curl --unix-socket /var/www/api.interflux.com/sockets/puma.sock http://localhost/sanity-check -H "Content-Type: application/vnd.api+json" | jq
# )

# and echo Removing all builds except the latest one
# and echo find ../ -mindepth 1 -maxdepth 1 -type d -not -name $revision -exec echo rm -rf {} \;
# and find ../ -mindepth 1 -maxdepth 1 -type d -not -name $revision -exec echo rm -rf {} \;
# and find ../ -mindepth 1 -maxdepth 1 -type d -not -name $revision -exec rm -rf {} \;

echo "----------"
echo "Deploy successful!"
echo "----------"
