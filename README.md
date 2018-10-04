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

```
git clone git@github.com:janwerkhoven/api.interflux.com.git ~/Code/api.interflux.com
```
```
bundle install;
rake db:create;
rake db:migrate;
env RAILS_ENV=test;
rake db:migrate
```
