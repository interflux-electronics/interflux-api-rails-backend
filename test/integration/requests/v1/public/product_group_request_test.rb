require 'test_helper'

module V1
  module Public
    class ProductGroupRequestTest < V1::IntegrationTest
      # Public users should be able to fetch all products
      test '1' do
        assert_can_fetch_all true, 21
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
        ProductGroup
      end

      def path
        '/v1/public/product-groups'
      end

      def headers
        public_header
      end

      def test_fixture
        product_groups('soldering_fluxes')
      end

      def expected_attributes
        %i[
          slug
          name_single
          name_plural
        ]
      end

      def expected_relationships
        %i[
          parent_group
        ]
      end
    end
  end
end
