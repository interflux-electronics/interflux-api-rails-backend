# Rails - api.interflux.com

This Rails app is the back-end for three Ember apps:

* [www.interflux.com](https://www.interflux.com)  
* [lmpa.interflux.com](https://lmpa.interflux.com)  
* [admin.interflux.com](https://admin.interflux.com)  

It is hosted on:

* [api.interflux.com](https://api.interflux.com)

Build status:

`master` | `production`
-------- | ------------
[![Build status](https://badge.buildkite.com/feec3c1bb9d5fa10832931944a2af6a98fa4d2225c3b002045.svg?branch=master)](https://buildkite.com/nabu/api-dot-interflux-dot-com) | [![Build status](https://badge.buildkite.com/feec3c1bb9d5fa10832931944a2af6a98fa4d2225c3b002045.svg?branch=production)](https://buildkite.com/nabu/api-dot-interflux-dot-com)

## Get started

1. Make sure you have `rbenv` for Ruby version control:
```
rbenv versions
```

2. Clone the project:
```
git clone git@github.com:janwerkhoven/api.interflux.com.git .
cd api.interflux.com
```

3. Install:
```
gem install bundler
rbenv rehash
bundle install
rake db:create;
rake db:migrate;
rails s
```

4. Code away!

## From feature to deploy flow

1. `git checkout master`
2. `git pull`
3. `git checkout -b feature/...`
4. `git push -u origin feature/...`
5. `git pull-request -b master -m "One good PR name"`
6. Open the PR, make all tests pass, merge to `master`.
7. Create a new PR from `master` to `production`
8. Name the PR "Release - Meaningful something"
9. Merge into `production`
10. After all tests pass in Buildkite, Mina will deploy to the production server.

## Manual deploy to remote

```
mina deploy
```

## Manually control the remote Puma

```
mina puma:stop
mina puma:start
```

## Test whether API is up:

Should throw JSON 404 error:
```
curl https://api.interflux.com/unknown
```
