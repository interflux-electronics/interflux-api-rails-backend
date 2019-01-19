#!/usr/bin/env puma

environment 'development'

workers 2
threads 0, 5

bind 'tcp://0.0.0.0:3000'
