require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  def setup
    @casual_user = users('casual_user')
    @casual_user_token = JsonWebToken.encode(user_id: @casual_user.id)
    @product = products('IF_2005M')
  end

  test 'Authenticated routes returns 401 missing-header errors' do
    get "/admin/products/#{@product.id}"
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'missing-header'
    assert_equal first_error['detail'], 'The header of your request is missing the Authorization field.'
  end

  test 'Authenticated routes returns 401 invalid-token errors' do
    get "/admin/products/#{@product.id}", headers: { 'Authorization': 'bogus-token' }
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'invalid-token'
    assert_equal first_error['detail'], 'Your JWT token is either invalid or expired.'
  end

  test 'Authenticated routes returns 401 missing-user errors' do
    get "/admin/products/#{@product.id}", headers: { 'Authorization': JsonWebToken.encode(user_id: 'unknown-ID') }
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'missing-user'
    assert_equal first_error['detail'], 'No user was found for your authentication token.'
  end

  test 'Authenticated routes returns 401 no-permission errors' do
    get "/admin/products/#{@product.id}", headers: { 'Authorization': @casual_user_token }
    assert_response 401
    first_error = JSON.parse(@response.body)['errors'][0]
    assert_equal first_error['status'], '401'
    assert_equal first_error['code'], 'no-permission'
  end
end
