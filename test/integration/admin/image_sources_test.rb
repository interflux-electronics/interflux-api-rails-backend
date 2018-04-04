require 'test_helper'

class AdminImageTest < ActionDispatch::IntegrationTest
  def setup
    @source = images('image_source_1a')
    @image = images('image_1')
    @product = products('IF_2005M')
    @chinese = languages('chinese')
  end

  test 'Users can fetch all images of one particular product' do
    params = {
      filter: {
        type: 'Product',
        id: @product.id
      }
    }
    get '/admin/image-sources/', headers: admin_header, params: params
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 3, data.length
  end

  test 'Users can fetch a single image by ID' do
    get "/admin/image-sources/#{@source.id}", headers: admin_header
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
    get '/admin/image-sources/123', headers: admin_header
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
    post '/admin/image-sources', params: json, headers: admin_header
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
    put "/admin/image-sources/#{@image.id}", params: json, headers: admin_header
    assert_response 204
    assert_equal Image.find_by_id(@image.id).alt, 'Updated alt text'
  end

  test 'Users can delete a product image' do
    id = @image.id
    refute_nil Image.for_products.find_by_id(id)
    delete "/admin/image-sources/#{id}", headers: admin_header
    assert_nil Image.for_products.find_by_id(id)
  end

  test 'Unauthorized requests' do
    get '/admin/image-sources'
    assert_response 401
    get "/admin/image-sources/#{@image.id}"
    assert_response 401
    post '/admin/image-sources'
    assert_response 401
    put "/admin/image-sources/#{@image.id}"
    assert_response 401
    delete "/admin/image-sources/#{@image.id}"
    assert_response 401
  end

  test 'Forbidden requests' do
    post '/admin/image-sources', headers: admin_header
    assert_response 403
    put "/admin/image-sources/#{@image.id}", headers: admin_header
    assert_response 403
    delete "/admin/image-sources/#{@image.id}", headers: admin_header
    assert_response 403
  end
end
