require 'test_helper'

class AdminProductTest < ActionDispatch::IntegrationTest
  describe 'without authentication' do
    describe 'GET' do
      describe '#index' do
        it 'returns 401' do
          get '/admin/products'
          assert_response 401
        end
      end

      describe '#show' do
        it 'returns 401 by ID' do
          get "/admin/products/#{products('IF_2005M').id}"
          assert_response 401
        end
        it 'returns 401 by slug' do
          get "/admin/products/?slug=#{products('IF_2005M').slug}"
          assert_response 401
        end
      end
    end

    describe 'POST' do
      it 'returns 401' do
        post '/admin/products', params: {}
        assert_response 401
      end
    end

    describe 'PUT' do
      it 'returns 401' do
        put "/admin/products/#{products('IF_2005M').id}", params: {}
        assert_response 401
      end
    end

    describe 'DELETE' do
      it 'returns 401' do
        delete "/admin/products/#{products('IF_2005M').id}"
        assert_response 401
      end
    end
  end

  describe 'authenticated' do
    before do
      admin_user = users('admin_user')
      user_token = JsonWebToken.encode(user_id: admin_user.id)
      @authorized_header = { 'Authorization': user_token }
    end

    describe 'GET' do
      describe '#index' do
        it 'return all products' do
          get '/admin/products', headers: @authorized_header
          assert_response 200
          data = JSON.parse(@response.body)['data']
          assert_equal data.length, 6, 'Should return 6 products'
          refute_empty data.find { |p| p['id'] == products('IF_2005M').id }
          refute_empty data.find { |p| p['id'] == products('OSPI_3311M').id }
          refute_empty data.find { |p| p['id'] == products('pacific_2009M').id }
          refute_empty data.find { |p| p['id'] == products('DP_5600').id }
          refute_empty data.find { |p| p['id'] == products('QF_70').id }
          refute_empty data.find { |p| p['id'] == products('QF_50').id }
        end
      end

      describe '#show' do
        it 'returns product by ID' do
          get "/admin/products/#{products('IF_2005M').id}", headers: @authorized_header
          assert_response 200
          data = JSON.parse(@response.body)['data']
          assert_equal data['id'], products('IF_2005M').id
          assert_equal data['attributes']['name'], products('IF_2005M').name
        end
        it 'returns product by slug' do
          get "/admin/products/?slug=#{products('IF_2005M').slug}", headers: @authorized_header
          assert_response 200
          data = JSON.parse(@response.body)['data']
          assert_equal data['id'], products('IF_2005M').id
          assert_equal data['attributes']['name'], products('IF_2005M').name
        end
        it 'returns 422 for bogus ID' do
          get '/admin/products/123', headers: @authorized_header
          assert_response 422
        end
        it 'returns 422 for bogus slug' do
          get '/admin/products/?slug=bogus', headers: @authorized_header
          assert_response 422
        end
      end
    end

    describe 'POST' do
      it 'creates a product' do
        json = {
          data: {
            type: 'products',
            attributes: {
              name: 'New Product éçüñ',
              public: false,
              pitch: nil,
              body: nil
            },
            relationships: {
              'main-category': {
                data: {
                  type: 'product-categories',
                  id: product_categories('soldering_fluxes').id
                }
              },
              'sub-category': {
                data: {
                  type: 'product-categories',
                  id: product_categories('voc_free').id
                }
              }
            }
          }
        }
        assert_equal Product.count, 6
        post '/admin/products', params: json, headers: @authorized_header
        assert_response 201
        assert_equal Product.count, 7
        refute_empty Product.where(name: 'New Product éçüñ')
        product = Product.where(name: 'New Product éçüñ').first
        data = JSON.parse(@response.body)['data']
        assert_equal data['id'], product.id, 'The response includes the ID of the created product (important)'
        assert_equal data['attributes']['name'], 'New Product éçüñ'
        assert_equal data['attributes']['slug'], 'New-Product-ecun'
      end
    end

    describe 'PUT' do
      it 'updates a product' do
        json = {
          data: {
            type: 'products',
            attributes: {
              name: 'Updated Product',
              public: false,
              pitch: nil,
              body: nil
            },
            relationships: {
              'main-category': {
                data: {
                  type: 'product-categories',
                  id: product_categories('soldering_fluxes').id
                }
              },
              'sub-category': {
                data: {
                  type: 'product-categories',
                  id: product_categories('voc_free').id
                }
              }
            }
          }
        }
        assert_equal products('IF_2005M').name, 'IF 2005M'
        put "/admin/products/#{products('IF_2005M').id}", params: json, headers: @authorized_header
        assert_response 204
        product = Product.find_by(id: products('IF_2005M').id)
        assert_equal product.name, 'Updated Product'
        assert_equal product.slug, 'Updated-Product'
      end
    end

    describe 'DELETE' do
      it 'deletes a product' do
        assert_equal Product.count, 6
        refute_empty Product.where(name: products('IF_2005M').name)
        delete "/admin/products/#{products('IF_2005M').id}", headers: @authorized_header
        assert_equal Product.count, 5
        assert_empty Product.where(name: products('IF_2005M').name)
      end
    end
  end
end
