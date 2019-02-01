require 'test_helper'

class NotFound404Test < ActionDispatch::IntegrationTest
  test 'GET to unknown index route returns 404' do
    get '/unknown'
    assert_response 404
  end

  test 'GET to unknown show route returns 404' do
    get '/unknown/123'
    assert_response 404
  end

  test 'GET to unknown v1 index route returns 404' do
    get '/v1/unknown'
    assert_response 404
  end

  test 'GET to unknown v1 show route returns 404' do
    get '/v1/unknown/123'
    assert_response 404
  end

  test 'POST to unknown route returns 404' do
    post '/unknown/123'
    assert_response 404
  end

  test 'PUT to unknown route returns 404' do
    put '/unknown/123'
    assert_response 404
  end

  test 'DELETE to unknown route returns 404' do
    delete '/unknown/123'
    assert_response 404
  end
end
