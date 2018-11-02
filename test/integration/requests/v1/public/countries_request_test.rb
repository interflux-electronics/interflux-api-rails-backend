require 'test_helper'

module V1
  module Public
    class CountriesRequestTest < ActionDispatch::IntegrationTest
      def setup
        @belgium = countries('Belgium')
        @australia = countries('Australia')
        @attributes = %i[
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
        ]
      end

      test 'Public users can fetch all countries' do
        get '/v1/public/countries', headers: public_header
        data = JSON.parse(@response.body)['data']
        assert_response 200
        assert_equal Array, data.class
        assert_equal 248, data.length
        # TODO: For relationships:
        # main_categories = data.find_all { |x| x['relationships']['parent-category']['data'].nil? }
        # sub_categories = data.find_all { |x| !x['relationships']['parent-category']['data'].nil? }
        # assert_equal 5, main_categories.length
        # assert_equal 16, sub_categories.length
      end

      test 'Public users can fetch a single country by ID' do
        get "/v1/public/countries/#{@belgium.id}", headers: public_header
        data = JSON.parse(@response.body)['data']
        assert_response 200
        assert_equal Hash, data.class
        assert_equal data['id'], @belgium.id
        assert_equal data['attributes'].length, @attributes.length
        assert_equal data['attributes']['name'], 'Belgium'
        assert_equal data['attributes']['native_name'], 'België'
        assert_equal data['attributes']['region'], 'Europe'
        assert_equal data['attributes']['subregion'], 'Western Europe'
        assert_equal data['attributes']['alpha_2_code'], 'BE'
        assert_equal data['attributes']['alpha_3_code'], 'BEL'
        assert_equal data['attributes']['numeric_code'], '056'
        assert_equal data['attributes']['flag'], 'https://restcountries.eu/data/bel.svg'
        # TODO: assert_equal data['attributes']['latlng'], '50.83333333, 4.0'
        assert_equal data['attributes']['area'], '30528.0'
        assert_equal data['attributes']['population'], '11319511.0'
        # TODO: assert_equal data['attributes']['languages'], '...'
        # TODO: assert_equal data['attributes']['timezones'], '...'
        # TODO: assert_equal data['attributes']['currencies'], '...'
        # TODO: assert_equal data['attributes']['top_level_domains'], '...'
        # TODO: assert_equal data['attributes']['calling_codes'], '...'
        # assert_equal data['relationships']['parent-category']['data']['id'], product_categories('soldering_fluxes').id
        # assert_equal data['relationships'].length, 1
      end

      test 'Public users cannot create countries' do
        post '/v1/public/countries', headers: public_header
        assert_response 403
      end

      test 'Public users cannot update countries' do
        put "/v1/public/countries/#{@belgium.id}", headers: public_header
        assert_response 403
      end

      test 'Public users cannot delete countries' do
        delete "/v1/public/countries/#{@belgium.id}", headers: public_header
        assert_response 403
      end
    end
  end
end
