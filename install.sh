#!/usr/bin/env bash

set -e
set -o pipefail

# Hack to load rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

echo "----------"
echo "User: $USER"
echo "Host: $HOSTNAME"
echo "Path: $PWD"
echo "Branch: $1"
echo "Revision: $2"
echo "----------"
echo "cd /var/www/api.interflux.com"
cd /var/www/api.interflux.com
echo "----------"
echo "rm -rf ./releases/latest"
rm -rf ./releases/latest
echo "----------"
echo "git clone -b production --single-branch git@github.com:janwerkhoven/api.interflux.com.git ./releases/latest"
git clone -b production --single-branch git@github.com:janwerkhoven/api.interflux.com.git ./releases/latest
echo "----------"
echo "cp .rbenv-vars releases/latest/"
cp .rbenv-vars releases/latest/
echo "----------"
echo "cd ./releases/latest"
cd ./releases/latest
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
echo "bin/bundle install"
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
echo "bin/bundle exec puma -e production"
bin/bundle exec puma -e production
echo "----------"
echo "curl http://0.0.0.0:3000/status"
curl http://0.0.0.0:3000/status
echo "----------"
echo "Deploy successful!"
echo "----------"
