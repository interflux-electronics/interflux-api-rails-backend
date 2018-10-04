require 'test_helper'
require 'minitest/autorun'

class AdminProductTest < ActionDispatch::IntegrationTest
  describe 'TIETEN' do
    def setup
      @IF_2005M = products('IF_2005M')
    end

    it 'Users can fetch all products' do
      get '/admin/products', headers: admin_header
      data = JSON.parse(@response.body)['data']
      assert_response 200
      assert_equal Array, data.class
      assert_equal 6, data.length
    end

    it 'Users can fetch a single product by ID' do
      get "/admin/products/#{@IF_2005M.id}", headers: admin_header
      data = JSON.parse(@response.body)['data']
      assert_response 200
      assert_equal Hash, data.class
      assert_nil data['attributes']['body'], nil
      assert_equal data['attributes']['name'], 'IF 2005M'
      assert_equal data['attributes']['pitch'], 'Interflux® IF 2005M is the **internationally renowned** resin- and rosin-free, no-clean / No-residue™ **flux standard**.'
      assert_equal data['attributes']['public'], true
      assert_equal data['attributes']['slug'], 'IF-2005M'
      assert_equal data['attributes'].length, 5
      assert_equal data['relationships']['main-category']['data']['id'], product_categories('soldering_fluxes').id
      assert_equal data['relationships']['sub-category']['data']['id'], product_categories('alcohol_based').id
      assert_equal data['relationships'].length, 2
    end

    test 'Users can fetch a single product by slug' do
      get "/admin/products/?slug=#{@IF_2005M.slug}", headers: admin_header
      data = JSON.parse(@response.body)['data']
      assert_response 200
      assert_equal Hash, data.class
      assert_equal data['id'], @IF_2005M.id
      assert_nil data['attributes']['body'], nil
      assert_equal data['attributes']['name'], 'IF 2005M'
      assert_equal data['attributes']['pitch'], 'Interflux® IF 2005M is the **internationally renowned** resin- and rosin-free, no-clean / No-residue™ **flux standard**.'
      assert_equal data['attributes']['public'], true
      assert_equal data['attributes']['slug'], 'IF-2005M'
      assert_equal data['attributes'].length, 5
      assert_equal data['relationships']['main-category']['data']['id'], product_categories('soldering_fluxes').id
      assert_equal data['relationships']['sub-category']['data']['id'], product_categories('alcohol_based').id
      assert_equal data['relationships'].length, 2
    end

    test 'Returns 422 for bogus IDs' do
      get '/admin/products/123', headers: admin_header
      assert_response 422
    end

    test 'Returns 422 for bogus slugs' do
      get '/admin/products/?slug=bogus', headers: admin_header
      assert_response 422
    end

    test 'Users can create a product' do
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
                type: 'products',
                id: product_categories('soldering_fluxes').id
              }
            },
            'sub-category': {
              data: {
                type: 'products',
                id: product_categories('voc_free').id
              }
            }
          }
        }
      }
      assert_equal Product.count, 6
      post '/admin/products', params: json, headers: admin_header
      assert_response 201
      assert_equal Product.count, 7
      refute_empty Product.where(name: 'New Product éçüñ')
      product = Product.where(name: 'New Product éçüñ').first
      data = JSON.parse(@response.body)['data']
      assert_equal data['id'], product.id, 'The response includes the ID of the created product (important)'
      assert_equal data['attributes']['name'], 'New Product éçüñ'
      assert_equal data['attributes']['slug'], 'New-Product-ecun'
    end

    test 'Users can update a product' do
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
                type: 'products',
                id: product_categories('soldering_fluxes').id
              }
            },
            'sub-category': {
              data: {
                type: 'products',
                id: product_categories('voc_free').id
              }
            }
          }
        }
      }
      assert_equal products('IF_2005M').name, 'IF 2005M'
      put "/admin/products/#{@IF_2005M.id}", params: json, headers: admin_header
      assert_response 204
      product = Product.find_by(id: products('IF_2005M').id)
      assert_equal product.name, 'Updated Product'
      assert_equal product.slug, 'Updated-Product'
    end

    test 'Users can delete a product' do
      assert_equal Product.count, 6
      refute_empty Product.where(name: products('IF_2005M').name)
      delete "/admin/products/#{@IF_2005M.id}", headers: admin_header
      assert_equal Product.count, 5
      assert_empty Product.where(name: products('IF_2005M').name)
    end

    test 'Unauthorized requests' do
      get '/admin/products'
      assert_response 401
      get "/admin/products/#{@IF_2005M.id}"
      assert_response 401
      post '/admin/products'
      assert_response 401
      put "/admin/products/#{@IF_2005M.id}"
      assert_response 401
      delete "/admin/products/#{@IF_2005M.id}"
      assert_response 401
    end
  end
end
