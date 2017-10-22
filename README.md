# README

gem install bundle; bundle install; bundle exec rake db:migrate; bundle exec rake db:migrate RAILS_ENV=test

rails db:drop && rails db:create && rails db:migrate && rails db:migrate RAILS_ENV=test && rails db:seed

# How to auth:
# curl -H "Content-Type: application/json" -X POST -d '{"email":"example@mail.com","password":"123123123"}' http://localhost:3000/authenticate
# curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDc0NDMwMTB9.xPlcqij4Gpi9wnPvgmI8rdVP23b7Zw1yBD22uu8nApI" http://localhost:3000/admin/products
# http GET http://localhost:3000/admin/products Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDc0NDMwMTB9.xPlcqij4Gpi9wnPvgmI8rdVP23b7Zw1yBD22uu8nApI

# Update password
# User.create!(email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123')
# User.where(email: 'jw@interflux.com').first.update!(password: 'password123' , password_confirmation: 'password123')
