#!/usr/bin/env bash

set -e
set -o pipefail

# Hack to load rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

BRANCH=$1
REVISION=$2

echo "----------"
echo "User: $USER"
echo "Host: $HOSTNAME"
echo "Path: $PWD"
echo "Branch: $BRANCH"
echo "Revision: $REVISION"
echo "----------"
echo "cd /var/www/api.interflux.com"
cd /var/www/api.interflux.com
echo "----------"
echo "rm -rf builds/$BRANCH/$REVISION"
rm -rf builds/$BRANCH/$REVISION
echo "----------"
echo "mkdir -p builds/$BRANCH/$REVISION"
mkdir -p builds/$BRANCH/$REVISION
echo "----------"
echo "git --git-dir=repo fetch"
git --git-dir=repo fetch
echo "----------"
echo "git --git-dir=repo --work-tree=builds/$BRANCH/$REVISION checkout $REVISION -f"
git --git-dir=repo --work-tree=builds/$BRANCH/$REVISION checkout $REVISION -f
echo "----------"
echo "cp .rbenv-vars builds/$BRANCH/$REVISION"
cp .rbenv-vars builds/$BRANCH/$REVISION
echo "----------"
echo "cd builds/$BRANCH/$REVISION"
cd builds/$BRANCH/$REVISION
echo "----------"
echo "rbenv install -s"
~/.rbenv/bin/rbenv install --skip-existing
echo "----------"
echo "rbenv rehash"
rbenv rehash
echo "----------"
echo "gem install bundler"
gem install bundler
echo "----------"
echo "gem install rails"
gem install rails
echo "----------"
echo "bin/bundle install --binstubs"
bin/bundle install
echo "----------"
echo "export RAILS_ENV=production"
export RAILS_ENV=production
echo "----------"
echo "bin/rails db:create"
bin/rails db:create
echo "----------"
echo "bin/rails db:migrate"
bin/rails db:migrate
echo "----------"
echo "ln -nsf /var/www/api.interflux.com/builds/$BRANCH/$REVISION /var/www/api.interflux.com/builds/current"
ln -nsf /var/www/api.interflux.com/builds/$BRANCH/$REVISION /var/www/api.interflux.com/builds/current
echo "----------"
echo "bin/bundle exec pumactl -F config/puma/production.rb restart"
bin/bundle exec pumactl -F config/puma/production.rb restart
echo "----------"
echo "Deploy successful!"
echo "----------"
