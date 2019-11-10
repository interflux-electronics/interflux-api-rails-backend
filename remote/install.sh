#!/usr/bin/fish

set user (whoami)
set host (hostname)
set path (dirname (status --current-filename))
set branch $argv[1]
set revision $argv[2]

echo ----------
echo User: $user
echo Host: $host
echo Path: $path
echo Branch: $branch
echo Revision: $revision
echo ----------
echo cd $path
cd $path
and echo ----------
and echo rm -rf builds/$branch/$revision
and rm -rf builds/$branch/$revision
and echo ----------
and echo mkdir -p builds/$branch/$revision
and mkdir -p builds/$branch/$revision
and echo ----------
and echo git --git-dir=repo fetch
and git --git-dir=repo fetch
and echo ----------
and echo git --git-dir=repo --work-tree=builds/$branch/$revision checkout $revision -f
and git --git-dir=repo --work-tree=builds/$branch/$revision checkout $revision -f
and echo ----------
and echo cd builds/$branch/$revision
and cd builds/$branch/$revision
and echo ----------
and echo "GIT_BRANCH=$branch >> .rbenv-vars"
and echo "GIT_REVISION=$revision >> .rbenv-vars"
and echo "GIT_BRANCH=$branch" >> .rbenv-vars
and echo "GIT_REVISION=$revision" >> .rbenv-vars
and echo ----------
and echo rbenv install -s
and rbenv install -s
and echo ----------
and echo rbenv rehash
and rbenv rehash
and echo ----------
and echo gem install bundler
and gem install bundler
and echo ----------
and echo gem install rails
and gem install rails
and echo ----------
and echo bin/bundle install
and bin/bundle install
# and echo ----------
# and echo env RAILS_ENV=production bin/rails db:create
# and env RAILS_ENV=production bin/rails db:create
# and echo ----------
# and echo bin/rails db:environment:set RAILS_ENV=production
# and bin/rails db:environment:set RAILS_ENV=production
and echo ----------
and echo bin/rails db:migrate
and env RAILS_ENV=production bin/rails db:migrate
# and echo ----------
# and echo bin/rails db:seed
# and env RAILS_ENV=production bin/rails db:seed
and echo ----------
and set head (git --git-dir=/var/www/api.interflux.com/repo rev-parse --short HEAD)
ln -nsf /var/www/api.interflux.com/builds/$branch/$head /var/www/api.interflux.com/builds/$branch/latest
