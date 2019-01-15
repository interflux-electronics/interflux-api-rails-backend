#!/usr/bin/env bash

set -e
set -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
script_filename="$(basename "${BASH_SOURCE[0]}")"
cd $script_dir

echo "----------"
echo "User: $USER"
echo "Host: $HOSTNAME"
echo "Path: $PWD"
echo "----------"
echo "Running $script_filename ..."
echo "----------"
echo "git pull"
git pull
echo "----------"
echo "git checkout 'production' -f"
git checkout 'production' -f
echo "----------"
rbenv install
echo "----------"
gem install bundler
echo "----------"
gem install rails
echo "----------"
bundle install
echo "----------"
