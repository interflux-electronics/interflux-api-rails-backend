require 'test_helper'

module V1
  module Public
    class LeadsRequestTest < ActionDispatch::IntegrationTest
      def setup
        @lead_one = leads('one')
      end

      test 'Public users can fetch all countries' do
        get '/v1/public/leads', headers: public_header
        assert_response 403
      end

      test 'Public users can fetch a single country by ID' do
        get "/v1/public/leads/#{@lead_one.id}", headers: public_header
        assert_response 403
      end

      test 'Public users can create leads' do
        json = {
          data: {
            type: 'products',
            attributes: {
              name: 'Jan Werkhoven',
              company: 'Interflux Electronics',
              email: 'j.werkhoven@interflux.com',
              mobile: '+61 424 787 652',
              purpose: 'Request LMPA demo',
              message: 'Hello Interflux, please send me your best LMPA expert.',
              source: 'https://lmpa.interflux.com/en/request-free-demo'
            }
          }
        }
        assert_equal Lead.count, 1
        post '/v1/public/leads', params: json, headers: public_header
        assert_response 201
        assert_equal Lead.count, 2
        new_record = Lead.where(name: 'Jan Werkhoven').first
        data = JSON.parse(@response.body)['data']
        assert_equal data['id'], new_record.id, 'The response includes the ID of the created lead (important)'
        assert_equal data['attributes']['name'], 'Jan Werkhoven'
        assert_equal data['attributes']['company'], 'Interflux Electronics'
        assert_equal data['attributes']['email'], 'j.werkhoven@interflux.com'
        assert_equal data['attributes']['mobile'], '+61 424 787 652'
        assert_equal data['attributes']['purpose'], 'Request LMPA demo'
        assert_equal data['attributes']['message'], 'Hello Interflux, please send me your best LMPA expert.'
        assert_equal data['attributes']['source'], 'https://lmpa.interflux.com/en/request-free-demo'
      end

      test 'Public users cannot update countries' do
        put "/v1/public/countries/#{@lead_one.id}", headers: public_header
        assert_response 403
      end

      test 'Public users cannot delete countries' do
        delete "/v1/public/countries/#{@lead_one.id}", headers: public_header
        assert_response 403
      end
    end
  end
end
