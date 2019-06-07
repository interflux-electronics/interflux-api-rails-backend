require 'test_helper'

module V1
  module Public
    class ProductIntegrationTest < ActionDispatch::IntegrationTest
      def setup
        @header = public_header
      end

      test 'can fetch all products' do
        get '/v1/public/products', headers: @header

        # Should be allowed
        assert_response 200

        json = JSON.parse(@response.body)

        # Should return 4 out of 5 products (should filter out public=false)
        assert_equal 4, json['data'].length
      end

      test 'can fetch one product by slug' do
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
        refute_nil json['data']['attributes']['continued']

        # Returns relationships
        refute_nil json['data']['relationships']['product-family']

        # Should not include other records included
        assert_nil json['includes']
      end

      test 'can include product family' do
        # curl "http://localhost:3000/v1/public/products?slug=LMPA-Q6&include=product-family" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?slug=LMPA-Q6&include=product-family', headers: @header

        json = JSON.parse(@response.body)

        # Includes extra records
        refute_nil json['included']
        assert_equal 1, json['included'].length
        assert_equal 'Solder paste', json['included'][0]['attributes']['name-single']
      end

      test 'can filter one' do
        # curl "http://localhost:3000/v1/public/products?filter%5Bcontinued%5D=true" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?filter[continued]=true', headers: @header

        json = JSON.parse(@response.body)

        # Should return 3 out of 5 products (should filter out continued=false)
        assert_equal 3, json['data'].length
      end

      test 'can filter two things' do
        # curl "http://localhost:3000/v1/public/products?filter%5Bcontinued%5D=true&filter%5Bname%5D=IF%202005M" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?filter[continued]=true&filter[name]=IF 2005M', headers: @header

        json = JSON.parse(@response.body)

        # Should return 3 out of 5 products (should filter out continued=false)
        assert_equal 1, json['data'].length
      end

      test 'throws 403 if wrong filter' do
        # curl "http://localhost:3000/v1/public/products?filter%5Bbogus%5D=true" -H "Content-Type: application/vnd.api+json"
        get '/v1/public/products?filter[bogus]=true', headers: @header
        assert_response 403
      end

      test 'do not allow create' do
        post '/v1/public/products', headers: @header
        assert_response 403
      end

      test 'do not allow update' do
        put '/v1/public/products/123', headers: @header
        assert_response 403
      end

      test 'do not allow delete' do
        delete '/v1/public/products/123', headers: @header
        assert_response 403
      end
    end
  end
end
