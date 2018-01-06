require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  def setup
    @casual_user = users('casual_user')
    @casual_user_token = JsonWebToken.encode(user_id: @casual_user.id)
  end

  test 'Authenticated routes throw 401 missing_header errors' do
    get "/admin/products/#{products('IF_2005M').id}"
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'missing-header'
    assert_equal first_error['detail'], 'The header of your request is missing the Authorization field.'
  end

  test 'Authenticated routes throw 401 invalid_token errors' do
    get "/admin/products/#{products('IF_2005M').id}", headers: { 'Authorization': 'bogus-token' }
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'invalid-token'
    assert_equal first_error['detail'], 'Your JWT token is either invalid or expired.'
  end

  test 'Authenticated routes throw 401 missing_user errors' do
    get "/admin/products/#{products('IF_2005M').id}", headers: { 'Authorization': JsonWebToken.encode(user_id: 'unknown-ID') }
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'missing-user'
    assert_equal first_error['detail'], 'No user was found for your authentication token.'
  end

  test 'Authenticated routes throw 401 no_permission errors' do
    get "/admin/products/#{products('IF_2005M').id}", headers: { 'Authorization': @casual_user_token }
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'no-permission'
  end
end
