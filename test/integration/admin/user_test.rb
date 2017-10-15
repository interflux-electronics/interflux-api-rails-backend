# frozen_string_literal: true

require 'test_helper'

class AdminUserIntegrationTest < ActionDispatch::IntegrationTest
  # How to auth:
  # curl -H "Content-Type: application/json" -X POST -d '{"email":"example@mail.com","password":"123123123"}' http://localhost:3000/authenticate
  # curl -H "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDc0NDMwMTB9.xPlcqij4Gpi9wnPvgmI8rdVP23b7Zw1yBD22uu8nApI" http://localhost:3000/admin/products
  # http GET http://localhost:3000/admin/products Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDc0NDMwMTB9.xPlcqij4Gpi9wnPvgmI8rdVP23b7Zw1yBD22uu8nApI

  # Update password
  # User.create!(email: 'example@mail.com' , password: '123123123' , password_confirmation: '123123123')
  # User.where(email: 'jw@interflux.com').first.update!(password: 'password123' , password_confirmation: 'password123')

  test 'User can receive auth token with login credentials' do
    @headers = {
      'Accept' => 'application/au.com.hotdoc.v4',
      'Content-Type' => 'application/json'
    }
    params = {
      patient: {
        email: 'demo@interflux.com',
        password: 'password'
      }
    }
    # post_json "/", {}, { "HTTP_AUTHORIZATION" => "Token token=1111" }
    # post_json '/authenticate', params, @headers
    post '/authenticate', params: params, as: :json
    # get "/profile", params: { id: 1 }, headers: { "X-Extra-Header" => "123" }
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal data['auth_token'], 'xxx'
  end
end
