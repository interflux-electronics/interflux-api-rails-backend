#!/usr/bin/env puma

environment 'development'

bind 'tcp://0.0.0.0:3000'

tag 'Puma - Interflux API - Development'
