require 'test_helper'

class ApplicationTest < ActionDispatch::IntegrationTest
  test 'GET to unknown route index returns 404' do
    get '/unknown'
    assert_response 404
  end

  test 'GET to unknown show route returns 404' do
    get '/unknown/123'
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
