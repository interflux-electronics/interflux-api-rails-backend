require 'test_helper'

module V1
  module Public
    class SolderingProcessesIntegrationTest < ActionDispatch::IntegrationTest
      def setup
        @header = public_header
      end

      test 'can fetch all' do
        get '/v1/public/soldering-processes', headers: @header

        # Should be allowed
        assert_response 200

        json = JSON.parse(@response.body)

        # Should return 4 soldering processes
        assert_equal 4, json['data'].length
      end

      test 'does not allow create' do
        post '/v1/public/soldering-processes', headers: @header
        assert_response 403
      end

      test 'does not allow update' do
        put '/v1/public/soldering-processes/123', headers: @header
        assert_response 403
      end

      test 'does not allow delete' do
        delete '/v1/public/soldering-processes/123', headers: @header
        assert_response 403
      end
    end
  end
end
