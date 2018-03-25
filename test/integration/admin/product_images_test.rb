require 'test_helper'

class AdminProductImageTest < ActionDispatch::IntegrationTest
  def setup
    @IF_2005M = products('IF_2005M')
    @image_1 = images('image_1')
    @chinese = languages('chinese')
  end

  test 'Users can fetch all images' do
    get '/admin/product-images', headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 4, data.length
  end

  test 'Users can fetch all images of a single product' do
    params = {
      filter: {
        'product-id': @IF_2005M.id
      }
    }
    get '/admin/product-images/', headers: admin_header, params: params
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 3, data.length
  end

  test 'Users can fetch a single image by ID' do
    get "/admin/product-images/#{@image_1.id}", headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Hash, data.class
    assert_equal data['id'], @image_1.id
    assert_equal data['attributes']['alt'], @image_1.alt
    assert_equal data['attributes'].length, 1
    assert_equal data['relationships']['image-owner']['data']['id'], @image_1.image_owner_id
    assert_equal data['relationships']['image-sources']['data'].length, 2
    assert_equal data['relationships']['image-translations']['data'].length, 2
    assert_equal data['relationships'].length, 3
  end

  test 'Returns 422 for bogus IDs' do
    get '/admin/product-images/123', headers: admin_header
    assert_response 422
  end

  test 'Users can create a product image' do
    json = {
      data: {
        type: 'product-image',
        attributes: {
          alt: 'Some alt text'
        },
        relationships: {
          'product': {
            data: {
              type: 'product',
              id: @IF_2005M.id
            }
          }
        }
      }
    }
    assert_equal Image.for_products.length, 4
    post '/admin/product-images', params: json, headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 201
    assert_equal Hash, data.class
    assert_equal Image.for_products.length, 5
    assert_equal data['attributes']['alt'], 'Some alt text'
    assert_equal data['attributes'].length, 1
    assert_equal data['relationships']['image-owner']['data']['id'], @image_1.image_owner_id
    assert_equal data['relationships']['image-sources']['data'].length, 0
    assert_equal data['relationships']['image-translations']['data'].length, 0
    assert_equal data['relationships'].length, 3
  end

  test 'Users can update a product image' do
    json = {
      data: {
        type: 'product-image',
        attributes: {
          alt: 'Updated alt text'
        },
        relationships: {
          'product': {
            data: {
              type: 'product',
              id: @IF_2005M.id
            }
          }
        }
      }
    }
    assert_equal @image_1.alt, '25 liter container, front view'
    put "/admin/product-images/#{@image_1.id}", params: json, headers: admin_header
    assert_response 204
    assert_equal Image.find_by_id(@image_1.id).alt, 'Updated alt text'
  end

  test 'Users can delete a product image' do
    id = @image_1.id
    refute_nil Image.for_products.find_by_id(id)
    delete "/admin/product-images/#{id}", headers: admin_header
    assert_nil Image.for_products.find_by_id(id)
  end

  test 'Unauthorized requests' do
    get '/admin/product-images'
    assert_response 401
    get "/admin/product-images/#{@image_1.id}"
    assert_response 401
    post '/admin/product-images'
    assert_response 401
    put "/admin/product-images/#{@image_1.id}"
    assert_response 401
    delete "/admin/product-images/#{@image_1.id}"
    assert_response 401
  end
end
