require 'test_helper'

module V1
  module Public
    class ProductTranslationRequestTest < V1::IntegrationTest
      # Public users should NOT be able to fetch all product translations
      test '1' do
        assert_can_fetch_all true, 3, 3
      end

      # Public users should be able to fetch one product translations by ID
      test '2' do
        assert_can_fetch_one_by_id true
      end

      # Public users should be able to fetch one product translations by slug
      test '3' do
        assert_can_fetch_one_by_slug true
      end

      # Public users should NOT be able to create product translations
      test '4' do
        assert_can_create false
      end

      # Public users should NOT be able to update product translations
      test '5' do
        assert_can_update false
      end

      # Public users should NOT be able to delete product translations
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
        ProductTranslation
      end

      def path
        '/v1/public/product-translations'
      end

      def headers
        public_header
      end

      def test_fixture
        product_translations('one')
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
          product
          language
        ]
      end
    end
  end
end
