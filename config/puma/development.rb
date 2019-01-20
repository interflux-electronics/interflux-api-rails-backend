#!/usr/bin/env puma

environment 'development'

bind 'tcp://0.0.0.0:3000'

tag 'Puma Server for Interflux API (development)'
