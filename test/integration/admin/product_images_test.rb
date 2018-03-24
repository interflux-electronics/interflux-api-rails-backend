require 'test_helper'

class AdminProductImageTest < ActionDispatch::IntegrationTest
  def setup
    @product = products('IF_2005M')
    @image_1 = images('image_1')
  end

  test 'Users can fetch' do
    get '/admin/product-images', headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 200, data.length
  end

  test 'Users can fetch all images of a single product' do
    get "/admin/product-images/?slug=#{@product.slug}", headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Array, data.class
    assert_equal 100, data.length
  end

  test 'Users can fetch a single image by ID' do
    get "/admin/product-images/#{@image_1.id}", headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 200
    assert_equal Hash, data.class
    assert_equal data['id'], @image_1.id
    # assert_equal data['attributes']['body'], @image_1.body
    # assert_equal data['attributes']['pitch'], @image_1.pitch
    # assert_equal data['attributes'].length, 2
    # assert_equal data['relationships']['product']['data']['id'], @image_1.product.id
    # assert_equal data['relationships']['language']['data']['id'], @image_1.language.id
    # assert_equal data['relationships'].length, 2
  end

  test 'Returns 422 for bogus IDs' do
    get '/admin/product-images/123', headers: admin_header
    assert_response 422
  end

  test 'Returns 422 for bogus slugs' do
    get '/admin/product-images/?slug=bogus', headers: admin_header
    assert_response 422
  end

  test 'Users can create a image' do
    json = {
      data: {
        type: 'product-image',
        attributes: {
          pitch: '吃饭',
          body: '招商好'
        },
        relationships: {
          'product': {
            data: {
              type: 'product',
              id: @product.id
            }
          },
          'language': {
            data: {
              type: 'language',
              id: @chinese.id
            }
          }
        }
      }
    }
    post '/admin/product-images', params: json, headers: admin_header
    data = JSON.parse(@response.body)['data']
    assert_response 201
    assert_equal Hash, data.class
    refute_equal data['id'], ProductImage.last.id
    assert_equal data['attributes']['body'], '招商好'
    assert_equal data['attributes']['pitch'], '吃饭'
    assert_equal data['attributes'].length, 2
    assert_equal data['relationships']['product']['data']['id'], @product.id
    assert_equal data['relationships']['language']['data']['id'], @chinese.id
    assert_equal data['relationships'].length, 2
  end

  test 'Users can update a image' do
    json = {
      data: {
        type: 'product-image',
        attributes: {
          pitch: '吃饭 interflux',
          body: '招商好 interflux'
        },
        relationships: {
          'product': {
            data: {
              type: 'product',
              id: @product.id
            }
          },
          'language': {
            data: {
              type: 'language',
              id: @chinese.id
            }
          }
        }
      }
    }
    put "/admin/product-images/#{@image_1.id}", params: json, headers: admin_header
    assert_response 204
    product = ProductImage.find_by(id: @image_1.id)
    assert_equal product.pitch, '吃饭 interflux'
    assert_equal product.body, '招商好 interflux'
  end

  test 'Users can delete a image' do
    id = @image_1.id
    refute_nil ProductImage.find_by(id: id)
    delete "/admin/product-images/#{id}", headers: admin_header
    assert_nil ProductImage.find_by(id: id)
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
