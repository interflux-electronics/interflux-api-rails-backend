require 'test_helper'

class AdminImageTest < ActionDispatch::IntegrationTest
  def setup
    @product = products('IF_2005M')
    @image = images('image_1')
    @chinese = languages('chinese')
  end

  test 'Users can fetch all images' do
    get '/admin/images', headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 4, data.length
  end

  test 'Users can fetch all images of one particular product' do
    params = {
      filter: {
        type: 'Product',
        id: @product.id
      }
    }
    get '/admin/images/', headers: admin_header, params: params
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 3, data.length
  end

  test 'Users can fetch a single image by ID' do
    get "/admin/images/#{@image.id}", headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Hash, data.class
    assert_equal data['id'], @image.id
    assert_equal data['attributes']['alt'], @image.alt
    assert_equal data['attributes'].length, 1
    assert_equal data['relationships']['image-owner']['data']['id'], @image.image_owner_id
    assert_equal data['relationships']['image-sources']['data'].length, 2
    assert_equal data['relationships']['image-translations']['data'].length, 2
    assert_equal data['relationships'].length, 3
  end

  test 'Returns 422 for bogus IDs' do
    get '/admin/images/123', headers: admin_header
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
              id: @product.id
            }
          }
        }
      }
    }
    assert_equal Image.for_products.length, 4
    post '/admin/images', params: json, headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 201
    assert_equal Hash, data.class
    assert_equal Image.for_products.length, 5
    assert_equal data['attributes']['alt'], 'Some alt text'
    assert_equal data['attributes'].length, 1
    assert_equal data['relationships']['image-owner']['data']['id'], @image.image_owner_id
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
              id: @product.id
            }
          }
        }
      }
    }
    assert_equal @image.alt, '25 liter container, front view'
    put "/admin/images/#{@image.id}", params: json, headers: admin_header
    assert_response 204
    assert_equal Image.find_by_id(@image.id).alt, 'Updated alt text'
  end

  test 'Users can delete a product image' do
    id = @image.id
    refute_nil Image.for_products.find_by_id(id)
    delete "/admin/images/#{id}", headers: admin_header
    assert_nil Image.for_products.find_by_id(id)
  end

  test 'Unauthorized requests' do
    get '/admin/images'
    assert_response 401
    get "/admin/images/#{@image.id}"
    assert_response 401
    post '/admin/images'
    assert_response 401
    put "/admin/images/#{@image.id}"
    assert_response 401
    delete "/admin/images/#{@image.id}"
    assert_response 401
  end
end
