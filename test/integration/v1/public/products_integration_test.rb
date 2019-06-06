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

        # Should return 4 out of 5 products (should filter out public=false)
        data = JSON.parse(@response.body)['data']
        assert_equal Array, data.class
        assert_equal 4, data.length
      end

      test 'can fetch one product by slug' do
        get '/v1/public/products?slug=LMPA-Q6', headers: @header

        # Should be allowed
        assert_response 200

        # Should return 4 out of 5 products (should filter out public=false)
        data = JSON.parse(@response.body)['data']

        # The response is JSON and has "data" as root key
        assert_equal Hash, data.class

        # Response includes the ID matching the slug
        refute_nil data['id']

        # Includes all expected attributes
        refute_nil data['attributes']['slug']
        refute_nil data['attributes']['name']
        refute_nil data['attributes']['continued']

        # Includes all expected relationships
        refute_nil data['relationships']['product-family']
      end

      test 'disallow create' do
        post '/v1/public/products', headers: @header
        assert_response 403
      end

      test 'disallow update' do
        put '/v1/public/products/123', headers: @header
        assert_response 403
      end

      test 'disallow delete' do
        delete '/v1/public/products/123', headers: @header
        assert_response 403
      end
    end
  end
end
