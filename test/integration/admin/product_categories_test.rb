require 'test_helper'

class AdminProductCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @alcohol_based = product_categories('alcohol_based')
  end

  test 'Authorized users can fetch all product categories' do
    get '/admin/product-categories', headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 21, data.length
    main_categories = data.find_all { |x| x['relationships']['parent-category']['data'].nil? }
    sub_categories = data.find_all { |x| !x['relationships']['parent-category']['data'].nil? }
    assert_equal 5, main_categories.length
    assert_equal 16, sub_categories.length
  end

  test 'Authorized users can fetch a single product category by ID' do
    get "/admin/product-categories/#{@alcohol_based.id}", headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Hash, data.class
    assert_equal data['id'], @alcohol_based.id
    assert_equal data['attributes']['slug'], 'alcohol-based'
    assert_equal data['attributes']['name-plural'], 'Alcohol-based soldering fluxes'
    assert_equal data['attributes']['name-single'], 'Alcohol-based soldering flux'
    assert_equal data['attributes'].length, 3
    assert_equal data['relationships']['parent-category']['data']['id'], product_categories('soldering_fluxes').id
    assert_equal data['relationships'].length, 1
  end

  test 'Unauthorized' do
    get '/admin/product-categories'
    assert_response 401
    get "/admin/product-categories/#{@alcohol_based.id}"
    assert_response 401
    post '/admin/product-categories'
    assert_response 401
    put "/admin/product-categories/#{@alcohol_based.id}"
    assert_response 401
    delete "/admin/product-categories/#{@alcohol_based.id}"
    assert_response 401
  end

  test 'Forbidden' do
    post '/admin/product-categories', headers: admin_header
    assert_response 403
    put "/admin/product-categories/#{@alcohol_based.id}", headers: admin_header
    assert_response 403
    delete "/admin/product-categories/#{@alcohol_based.id}", headers: admin_header
    assert_response 403
  end
end
