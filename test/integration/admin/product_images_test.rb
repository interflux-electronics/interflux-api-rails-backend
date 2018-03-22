require 'test_helper'

class AdminProductImagesTest < ActionDispatch::IntegrationTest
  describe 'logged in user' do
    before do
      admin_user = users('admin_user')
      user_token = JsonWebToken.encode(user_id: admin_user.id)
      @authorized_header = { 'Authorization': user_token }
    end

    describe 'GET' do
      describe '#index' do
        it 'returns all images' do
          get '/admin/product-images', headers: @authorized_header
          assert_response 200
          data = JSON.parse(@response.body)['data']
          data = JSON.parse(@response.body)['data']
          assert_equal data.length, 4
          refute_empty data.find { |p| p['id'] == images('image_1').id }
          refute_empty data.find { |p| p['id'] == images('image_2').id }
          refute_empty data.find { |p| p['id'] == images('image_3').id }
          refute_empty data.find { |p| p['id'] == images('image_4').id }
        end

        it 'returns all images of a specific product' do
          params = {
            filter: {
              type: 'Product',
              id: products('IF_2005M').id
            }
          }
          get '/admin/product-images', headers: @authorized_header, params: params
          assert_response 200
          data = JSON.parse(@response.body)['data']
          assert_equal 3, data.length
          refute_empty data.find { |p| p['id'] == images('image_1').id }
          refute_empty data.find { |p| p['id'] == images('image_2').id }
          refute_empty data.find { |p| p['id'] == images('image_3').id }
        end
      end

      describe '#show' do
        it 'returns 1 image by ID' do
          get "/admin/product-images/#{images('image_1').id}", headers: @authorized_header
          assert_response 200
          data = JSON.parse(@response.body)['data']
          assert_equal data['id'], images('image_1').id
          assert_equal data['attributes']['alt'], images('image_1').alt
        end
        it 'returns 422 for bogus ID' do
          get '/admin/product-images/123', headers: @authorized_header
          assert_response 422
        end
      end
    end

    describe 'POST' do
      it 'creates a image for a product' do
        json = {
          data: {
            type: 'images',
            attributes: {
              alt: 'new image'
            },
            relationships: {
              'image-owner': {
                data: {
                  type: 'Product',
                  id: products('IF_2005M').id
                }
              }
            }
          }
        }
        assert_equal Image.count, 4
        post '/admin/product-images', params: json, headers: @authorized_header
        assert_response 201
        assert_equal Image.count, 5
        refute_empty Image.where(alt: 'new image')
        image = Image.where(alt: 'new image').first
        data = JSON.parse(@response.body)['data']
        assert_equal data['id'], image.id, 'The response includes the ID of the created image (important)'
        assert_equal data['attributes']['alt'], 'new image'
      end
    end

    describe 'PUT' do
      it 'updates a image' do
        json = {
          data: {
            type: 'images',
            attributes: {
              alt: 'updated image'
            },
            relationships: {
              'image-owner': {
                data: {
                  type: 'Product',
                  id: products('IF_2005M').id
                }
              }
            }
          }
        }
        put "/admin/product-images/#{images('image_1').id}", params: json, headers: @authorized_header
        assert_response 204
        image = Image.find_by(id: images('image_1').id)
        assert_equal image.alt, 'updated image'
      end
    end

    describe 'DELETE' do
      it 'deletes a image' do
        assert_equal Image.count, 4
        delete "/admin/product-images/#{images('image_1').id}", headers: @authorized_header
        assert_equal Image.count, 3
      end
    end
  end

  describe 'unauthenticated user' do
    describe 'GET' do
      describe '#index' do
        it 'returns 401' do
          get '/admin/product-images'
          assert_response 401
        end
      end

      describe '#show' do
        it 'returns 401' do
          get "/admin/product-images/#{images('image_1').id}"
          assert_response 401
        end
      end
    end

    describe 'POST' do
      it 'returns 401' do
        post '/admin/product-images', params: {}
        assert_response 401
      end
    end

    describe 'PUT' do
      it 'returns 401' do
        put "/admin/product-images/#{images('image_1').id}", params: {}
        assert_response 401
      end
    end

    describe 'DELETE' do
      it 'returns 401' do
        delete "/admin/product-images/#{images('image_1').id}"
        assert_response 401
      end
    end
  end
end
