require 'test_helper'

module V1
  module Public
    class CountriesIntegrationTest < ActionDispatch::IntegrationTest
      def setup
        @header = public_header
      end

      test 'can fetch all' do
        get '/v1/public/countries', headers: @header
        assert_response 200
        json = JSON.parse(@response.body)
        assert_equal 2, json['data'].length
      end
    end
  end
end
