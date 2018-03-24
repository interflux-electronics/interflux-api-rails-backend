require 'test_helper'

class AdminLanguagesTest < ActionDispatch::IntegrationTest
  def setup
    @german = languages('german')
  end

  test 'Authorized users can fetch all languages' do
    get '/admin/languages', headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 15, data.length
  end

  test 'Authorized users can fetch a single language by ID' do
    get "/admin/languages/#{@german.id}", headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Hash, data.class
    assert_equal data['attributes']['locale'], 'de'
    assert_equal data['attributes']['name-english'], 'German'
    assert_equal data['attributes']['name-native'], 'Deutsch'
    assert_equal data['attributes'].length, 3
  end

  test 'Unauthorized' do
    get '/admin/languages'
    assert_response 401
    get "/admin/languages/#{@german.id}"
    assert_response 401
    post '/admin/languages'
    assert_response 401
    put "/admin/languages/#{@german.id}"
    assert_response 401
    delete "/admin/languages/#{@german.id}"
    assert_response 401
  end

  test 'Forbidden' do
    post '/admin/languages', headers: admin_header
    assert_response 403
    put "/admin/languages/#{@german.id}", headers: admin_header
    assert_response 403
    delete "/admin/languages/#{@german.id}", headers: admin_header
    assert_response 403
  end
end
