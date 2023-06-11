#!/usr/bin/env puma

environment 'development'

bind 'tcp://0.0.0.0:3000'
# bind 'ssl://127.0.0.1:3000?key=ssl/server.key&cert=ssl/server.crt'

tag 'Puma server for Interflux API (development)'

# Development often hangs unless you do this:
# https://github.com/rails/rails/issues/33209
workers 1
threads 1, 1

# Timeout after 10 minutes
worker_timeout 600
