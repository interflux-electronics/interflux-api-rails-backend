require 'test_helper'

module V1
  module Public
    class ProductIntegrationTest < ActionDispatch::IntegrationTest
      def setup
        @header = public_header
      end

      # curl 'http://localhost:3000/v1/public/products' -H "Content-Type: application/vnd.api+json"
      test 'can fetch all' do
        get '/v1/public/products', headers: @header

        # Should be allowed
        assert_response 200

        json = JSON.parse(@response.body)

        # Should return 4 out of 5 products (should filter out public=false)
        assert_equal 3, json['data'].length
      end

      test 'can fetch one by slug' do
        # curl 'http://localhost:3000/v1/public/products?slug=LMPA-Q6' -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?slug=LMPA-Q6', headers: @header

        # Should be allowed
        assert_response 200

        json = JSON.parse(@response.body)

        # Returns ID for given slug (important)
        refute_nil json['data']['id']

        # Returns attributes
        refute_nil json['data']['attributes']['slug']
        refute_nil json['data']['attributes']['name']
        refute_nil json['data']['attributes']['deprecated']
        refute_nil json['data']['attributes']['orderable']
        refute_nil json['data']['attributes']['popular']
        refute_nil json['data']['attributes']['new']

        # Returns relationships
        refute_nil json['data']['relationships']['product-family']

        # Should not include other records included
        assert_nil json['includes']
      end

      test 'can include product family' do
        # curl "http://localhost:3000/v1/public/products?slug=LMPA-Q6&include=product-family" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?slug=LMPA-Q6&include=product-family', headers: @header

        # Should be allowed
        assert_response 200

        json = JSON.parse(@response.body)

        # Includes extra records
        refute_nil json['included']
        assert_equal 1, json['included'].length
        assert_equal 'product-family', json['included'][0]['type']
        assert_equal 'solder paste', json['included'][0]['attributes']['name-single']
      end

      test 'can include family and images' do
        skip("TODO: includes become optional in the payload")

        # curl "http://localhost:3000/v1/public/products?slug=LMPA-Q6&include=product-family,product-images,product-images.image" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?slug=IF-2005M&include=product-family,product-images,product-images.image', headers: @header

        # Should be allowed
        assert_response 200

        json = JSON.parse(@response.body)

        # Includes 2 extra records
        refute_nil json['included']

        assert_equal 5, json['included'].length
        assert_equal 'product-family', json['included'][0]['type']
        assert_equal 'product-image', json['included'][1]['type']
        assert_equal 'product-image', json['included'][2]['type']
        assert_equal 'image', json['included'][3]['type']
        assert_equal 'image', json['included'][4]['type']
        assert_equal 'webp,jpg', json['included'][4]['attributes']['formats']
        # assert_equal 'product-variant', json['included'][5]['type']
        # assert_equal 'product-variant', json['included'][6]['type']
        # assert_equal 'product-variant', json['included'][7]['type']
        # assert_equal 'product-variant', json['included'][8]['type']
        # assert_equal 'container', json['included'][9]['type']
        # assert_equal 'container', json['included'][10]['type']
        # assert_equal 'container', json['included'][11]['type']
        # assert_equal 'container', json['included'][12]['type']
      end

      test 'can filter by deprecated' do
        # curl "http://localhost:3000/v1/public/products?filter%5Bdeprecated%5D=true" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?filter[deprecated]=true', headers: @header

        json = JSON.parse(@response.body)

        # Should return 1 out of 5 products (2 are deprecated, but 1 of them is not public)
        assert_equal 1, json['data'].length
      end

      test 'can filter by deprecated and name' do
        # curl "http://localhost:3000/v1/public/products?filter%5Bdeprecated%5D=true&filter%5Bname%5D=IF%202005M" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?filter[popular]=true&filter[name]=IF 2005M', headers: @header

        json = JSON.parse(@response.body)

        # Should return 1 out of 5 products
        assert_equal 1, json['data'].length
      end

      test 'throws 403 if bogus filter' do
        # curl "http://localhost:3000/v1/public/products?filter%5Bbogus%5D=true" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?filter[bogus]=true', headers: @header
        assert_response 403
      end

      test 'does not allow create' do
        post '/v1/public/products', headers: @header
        assert_response 403
      end

      test 'does not allow update' do
        put '/v1/public/products/123', headers: @header
        assert_response 403
      end

      test 'does not allow delete' do
        delete '/v1/public/products/123', headers: @header
        assert_response 403
      end
    end
  end
end
