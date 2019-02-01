require 'test_helper'

module V1
  module Public
    class ProductRequestTest < V1::IntegrationTest
      # Public users should be able to fetch all products
      test '1' do
        assert_can_fetch_all true, 5, 6
      end

      # Public users should be able to fetch one product by ID
      test '2' do
        assert_can_fetch_one_by_id true
      end

      # Public users should be able to fetch one product by slug
      test '3' do
        assert_can_fetch_one_by_slug true
      end

      # Public users should NOT be able to create products
      test '4' do
        assert_can_create false
      end

      # Public users should NOT be able to update products
      test '5' do
        assert_can_update false
      end

      # Public users should NOT be able to delete products
      test '6' do
        assert_can_delete false
      end

      # Fetching bogus IDs should return 404
      test '7' do
        assert_cannot_fetch_bogus_id
      end

      # Fetching bogus slugs should return 404
      test '8' do
        assert_cannot_fetch_bogus_slug
      end

      private

      def klass
        Product
      end

      def path
        '/v1/public/products'
      end

      def headers
        public_header
      end

      def test_fixture
        products('IF_2005M')
      end

      def expected_attributes
        %i[
          slug
          name
          pitch
        ]
      end

      def expected_relationships
        %i[
          main_group
          sub_group
          related_products
          related_articles
          translations
        ]
      end
    end
  end
end
