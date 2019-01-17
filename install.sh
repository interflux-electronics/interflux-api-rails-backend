#!/usr/bin/env bash

set -e
set -o pipefail

echo "----------"
echo "User: $USER"
echo "Host: $HOSTNAME"
echo "Path: $PWD"
echo "----------"
echo "rm -rf ./tmp/deploy"
rm -rf ./tmp/deploy
echo "----------"
echo "git clone -b production --single-branch git@github.com:janwerkhoven/api.interflux.com.git ./tmp/deploy"
git clone -b production --single-branch git@github.com:janwerkhoven/api.interflux.com.git ./tmp/deploy
echo "----------"
echo "cd ./tmp/deploy"
cd ./tmp/deploy
echo "----------"
echo "rbenv install 2.4.1 --skip-existing"
rbenv install --skip-existing
echo "----------"
echo "gem install bundler"
gem install bundler
echo "----------"
echo "gem install rails"
gem install rails
echo "----------"
echo "gem bundle install"
bundle install
echo "----------"
