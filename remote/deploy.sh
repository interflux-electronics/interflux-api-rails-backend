#!/usr/local/bin/fish

set remote "jw@server.interflux.com"
set path "/var/www/api.interflux.com"

set branch (git rev-parse --abbrev-ref HEAD)
set revision (git rev-parse --short HEAD)

and echo ----------
and echo Deploying:
and echo Branch: $branch
and echo Revision: $revision
and echo Remote: $remote
and echo ----------

switch $branch
case master
  echo git push
  git push
  and echo ----------
  and echo git checkout production -f
  and git checkout production -f
  and echo ----------
  and echo git pull origin master
  and git pull origin master
  and echo ----------
  and echo git push
  and git push
  and echo ----------
  and echo set branch (git rev-parse --abbrev-ref HEAD)
  and set branch (git rev-parse --abbrev-ref HEAD)
  and echo $branch
  and echo ----------
  and echo set revision (git rev-parse --short HEAD)
  and set revision (git rev-parse --short HEAD)
  and echo $revision
  and echo ----------
  and echo scp remote/install.sh $remote:$path
  and scp remote/install.sh $remote:$path
  and echo ----------
  and echo ssh $remote "$path/install.sh $branch $revision"
  and ssh $remote "$path/install.sh $branch $revision"
  and echo ----------
  and echo git checkout master
  and git checkout master
  and echo ----------
  and echo Merge and deploy successful!
  and echo ----------
case '*'
  echo Aborting - Only the master branch is deployable.
  echo ----------
end