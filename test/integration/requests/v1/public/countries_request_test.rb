require 'test_helper'

module V1
  module Public
    class CountriesRequestTest < V1::IntegrationTest
      # Public users should be able to fetch all countries
      test '1' do
        assert_can_fetch_all true, 248
      end

      # Public users should be able to fetch one country by ID
      test '2' do
        assert_can_fetch_one_by_id true
      end

      # Public users should NOT be able to fetch one country by slug
      test '3' do
        assert_can_fetch_one_by_slug false
      end

      # Public users should NOT be able to create countries
      test '4' do
        assert_can_create false
      end

      # Public users should NOT be able to update countries
      test '5' do
        assert_can_update false
      end

      # Public users should NOT be able to delete countries
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

      def path
        '/v1/public/countries'
      end

      def headers
        public_header
      end

      def test_fixture
        countries('Belgium')
      end

      def expected_attributes
        %i[
          name
          native_name
          region
          subregion
          alpha_2_code
          alpha_3_code
          numeric_code
          flag
          latlng
          area
          population
          languages
          timezones
          currencies
          top_level_domains
          calling_codes
          country_code
        ]
      end

      def expected_relationships
        %i[

        ]
      end
    end
  end
end
