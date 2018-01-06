require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest
  def setup
    @casual_user = users('casual_user')
    @casual_user_token = JsonWebToken.encode(user_id: @casual_user.id)
  end

  test 'Users can receive auth token with their login credentials' do
    post '/admin/login', params: { email: @casual_user.email, password: 'password' }
    assert_response 200
    response = JSON.parse(@response.body)
    token = response['auth_token']
    assert token
    assert_equal JsonWebToken.decode(token.split(' ').last)['user_id'], @casual_user.id
  end

  test 'Users get thrown a 401 invalid_login when logging in with unexisting email' do
    post '/admin/login', params: { email: 'doesnot@exist.com', password: 'password' }
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'invalid-email'
  end

  test 'Users get thrown a 401 invalid_login when logging in with wrong password' do
    post '/admin/login', params: { email: @casual_user.email, password: 'wrong-password' }
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'invalid-password'
  end
end
