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
echo "----------"
echo "cd /var/www/api.interflux.com"
cd /var/www/api.interflux.com
echo "----------"
echo "rm -rf ./tmp/deploy"
rm -rf ./tmp/deploy
echo "----------"
echo "git clone -b production --single-branch git@github.com:janwerkhoven/api.interflux.com.git ./tmp/deploy"
git clone -b production --single-branch git@github.com:janwerkhoven/api.interflux.com.git ./tmp/deploy
echo "----------"
echo "cp .rbenv-vars tmp/deploy/"
cp .rbenv-vars tmp/deploy/
echo "----------"
echo "cd ./tmp/deploy"
cd ./tmp/deploy
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
