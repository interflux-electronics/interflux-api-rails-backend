#!/usr/bin/fish

set user (whoami)
set host (hostname)
set path (dirname (status --current-filename))
set branch $argv[1]
set revision $argv[2]

echo -----------
echo REMOTE ----
echo -----------
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

# If first time
# and echo ----------
# and echo env RAILS_ENV=production bin/rails db:create
# and env RAILS_ENV=production bin/rails db:create
# and echo ----------
# and echo bin/rails db:environment:set RAILS_ENV=production
# and bin/rails db:environment:set RAILS_ENV=production

and echo ----------
and echo bin/rails db:migrate
and env RAILS_ENV=production bin/rails db:migrate
and echo ----------
and echo env RAILS_ENV=production bin/rails db:seed:truth
and env RAILS_ENV=production bin/rails db:seed:truth

# If needed
# and echo ----------
# and echo bin/rails db:seed
# and env RAILS_ENV=production bin/rails db:seed

and echo ----------
and echo set head (git --git-dir=/var/www/api.interflux.com/repo rev-parse --short HEAD)
and set head (git --git-dir=/var/www/api.interflux.com/repo rev-parse --short HEAD)
and echo ----------
and echo ln -nsf /var/www/api.interflux.com/builds/$branch/$head /var/www/api.interflux.com/builds/$branch/latest
and ln -nsf /var/www/api.interflux.com/builds/$branch/$head /var/www/api.interflux.com/builds/$branch/latest
and echo ----------
# Note, avoid `phased-restart` and `restart` for they have issues
and echo bin/pumactl -F config/puma/production.rb -T '12345' stop
and bin/pumactl -F config/puma/production.rb -T '12345' stop
and echo bin/pumactl -F config/puma/production.rb -T '12345' start
and bin/pumactl -F config/puma/production.rb -T '12345' start
and echo ----------
and echo Sanity check on remote:
and echo curl --unix-socket /var/www/api.interflux.com/sockets/puma.sock http://localhost/sanity-check -H "Content-Type: application/vnd.api+json"
and curl --unix-socket /var/www/api.interflux.com/sockets/puma.sock http://localhost/sanity-check -H "Content-Type: application/vnd.api+json"
and echo The responsonse above should be status:200 and revision:$revision.
and echo ----------
and echo Removing all builds except the latest one
and echo find ../ -mindepth 1 -maxdepth 1 -type d -not -name $revision -exec echo rm -rf {} \;
and find ../ -mindepth 1 -maxdepth 1 -type d -not -name $revision -exec echo rm -rf {} \;
and find ../ -mindepth 1 -maxdepth 1 -type d -not -name $revision -exec rm -rf {} \;
and echo ----------
and echo Remote install successful.
