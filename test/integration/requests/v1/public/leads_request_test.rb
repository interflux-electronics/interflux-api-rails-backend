require 'test_helper'

module V1
  module Public
    class LeadsRequestTest < ActionDispatch::IntegrationTest
      def setup
        @lead_one = leads('one')
        @belgium = countries('Belgium')
        @australia = countries('Australia')
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
              source: 'https://lmpa.interflux.com/en/request-free-demo',
              ip: '123.123.123.123',
              'ip-region': 'Victoria',
              'ip-city': 'Melbourne'
            },
            relationships: {
              'country': {
                data: {
                  type: 'country',
                  id: @belgium.id
                }
              },
              'ip-country': {
                data: {
                  type: 'country',
                  id: @australia.id
                }
              }
            }
          }
        }
        assert_equal Lead.count, 1
        post '/v1/public/leads', params: json, headers: public_header
        assert_response 201
        assert_equal Lead.count, 2
        new_record = Lead.where(name: 'Jan Werkhoven').first
        response = JSON.parse(@response.body)['data']
        assert_equal response['id'], new_record.id, 'The response includes the ID of the created lead (important)'
        assert_equal response['attributes']['name'], 'Jan Werkhoven'
        assert_equal response['attributes']['company'], 'Interflux Electronics'
        assert_equal response['attributes']['email'], 'j.werkhoven@interflux.com'
        assert_equal response['attributes']['mobile'], '+61 424 787 652'
        assert_equal response['attributes']['purpose'], 'Request LMPA demo'
        assert_equal response['attributes']['message'], 'Hello Interflux, please send me your best LMPA expert.'
        assert_equal response['attributes']['source'], 'https://lmpa.interflux.com/en/request-free-demo'
        assert_equal response['attributes']['ip'], '123.123.123.123'
        assert_equal response['attributes']['ip-region'], 'Victoria'
        assert_equal response['attributes']['ip-city'], 'Melbourne'
        assert_equal response['relationships']['country']['data']['id'], @belgium.id
        assert_equal response['relationships']['ip-country']['data']['id'], @australia.id
        assert_equal new_record.country.id, @belgium.id
        assert_equal new_record.country.name, @belgium.name
      end

      test 'Public users can submit empty messages and missing IP meta data' do
        json = {
          data: {
            type: 'products',
            attributes: {
              name: nil,
              company: nil,
              email: nil,
              mobile: nil,
              purpose: 'Request LMPA demo',
              message: nil,
              source: 'https://lmpa.interflux.com/en/request-free-demo',
              ip: nil,
              'ip-region': nil,
              'ip-city': nil
            }
          }
        }
        assert_equal Lead.count, 1
        post '/v1/public/leads', params: json, headers: public_header
        assert_response 201
        assert_equal Lead.count, 2
        response = JSON.parse(@response.body)['data']
        refute_empty response['id']
        assert_equal 11, response['attributes'].count
        assert_nil response['attributes']['name']
        assert_nil response['attributes']['company']
        assert_nil response['attributes']['email']
        assert_nil response['attributes']['mobile']
        assert_equal 'Request LMPA demo', response['attributes']['purpose']
        assert_nil response['attributes']['message']
        assert_equal 'https://lmpa.interflux.com/en/request-free-demo', response['attributes']['source']
        assert_nil response['attributes']['ip']
        assert_nil response['attributes']['ip-region']
        assert_nil response['attributes']['ip-city']
        assert_equal 2, response['relationships'].count
        assert_nil response['relationships']['country']['data']
        assert_nil response['relationships']['ip-country']['data']
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
