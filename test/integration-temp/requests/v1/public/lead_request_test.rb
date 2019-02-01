require 'test_helper'

module V1
  module Public
    class LeadRequestTest < V1::IntegrationTest
      include ActiveJob::TestHelper

      # Public users should NOT be able to fetch all leads
      test '1' do
        assert_can_fetch_all false, 0, 0
      end

      # Public users should NOT be able to fetch one lead by ID
      test '2' do
        assert_can_fetch_one_by_id false
      end

      # Public users should NOT be able to fetch one lead by slug
      test '3' do
        assert_can_fetch_one_by_slug false
      end

      # Public users should be able to create new leads
      test '4' do
        assert_can_create true
        assert_enqueued_jobs 1, only: PostLeadToSlackJob
      end

      # Public users should NOT be able to update leads
      test '5' do
        assert_can_update false
      end

      # Public users should NOT be able to delete leads
      test '6' do
        assert_can_delete false
      end

      # Fetching bogus IDs should return 422
      test '7' do
        assert_cannot_fetch_bogus_id
      end

      # Fetching bogus slugs should return 422
      test '8' do
        assert_cannot_fetch_bogus_slug
      end

      private

      def klass
        Lead
      end

      def path
        '/v1/public/leads'
      end

      def headers
        public_header
      end

      def test_fixture
        leads('complete')
      end

      def expected_attributes
        %i[
          name
          company
          email
          mobile
          purpose
          message
          source
          ip
          ip_region
          ip_city
        ]
      end

      def expected_relationships
        %i[
          country
          ip_country
        ]
      end

      def create_params
        {
          data: {
            type: 'products',
            attributes: {
              name: 'Jan Werkhoven',
              company: 'Interflux Electronics',
              email: 'j.werkhoven@interflux.com',
              mobile: '+61 424 787 652',
              purpose: 'Requesting LMPA demo',
              message: 'Hello Interflux, please send me your best LMPA expert. We are much interested in soldering with lower temperatures but first need to see your product work on our production line.',
              source: 'https://lmpa.interflux.com/en/request-free-demo',
              ip: '123.123.123.123',
              'ip-region': 'Victoria',
              'ip-city': 'Melbourne'
            },
            relationships: {
              'country': {
                data: {
                  type: 'country',
                  id: countries('Belgium').id
                }
              },
              'ip-country': {
                data: {
                  type: 'country',
                  id: countries('Australia').id
                }
              }
            }
          }
        }
      end
    end
  end
end

# require 'test_helper'
#
# module V1
#   module Public
#     class LeadsRequestTest < ActionDispatch::IntegrationTest
#       include ActiveJob::TestHelper
#
#       def setup
#         @lead = leads('complete')
#         @belgium = countries('Belgium')
#         @australia = countries('Australia')
#       end
#
#       test 'Public users cannot fetch all leads' do
#         get '/v1/public/leads', headers: public_header
#         assert_response 403
#       end
#
#       test 'Public users cannot fetch single leads by ID' do
#         get "/v1/public/leads/#{@lead.id}", headers: public_header
#         assert_response 403
#       end
#
#       test 'Public users can create complete leads' do
#         json = {
#           data: {
#             type: 'products',
#             attributes: {
#               name: 'Jan Werkhoven',
#               company: 'Interflux Electronics',
#               email: 'j.werkhoven@interflux.com',
#               mobile: '+61 424 787 652',
#               purpose: 'Requesting LMPA demo',
#               message: 'Hello Interflux, please send me your best LMPA expert. We are much interested in soldering with lower temperatures but first need to see your product work on our production line.',
#               source: 'https://lmpa.interflux.com/en/request-free-demo',
#               ip: '123.123.123.123',
#               'ip-region': 'Victoria',
#               'ip-city': 'Melbourne'
#             },
#             relationships: {
#               'country': {
#                 data: {
#                   type: 'country',
#                   id: @belgium.id
#                 }
#               },
#               'ip-country': {
#                 data: {
#                   type: 'country',
#                   id: @australia.id
#                 }
#               }
#             }
#           }
#         }
#         assert_equal 2, Lead.count
#         assert_enqueued_jobs 0
#
#         post '/v1/public/leads', params: json, headers: public_header
#
#         assert_response 201
#         assert_equal 3, Lead.count
#         new_record = Lead.where(name: 'Jan Werkhoven').first
#         response = JSON.parse(@response.body)['data']
#         refute_empty response['id']
#         assert_equal 'Jan Werkhoven', response['attributes']['name']
#         assert_equal 'Interflux Electronics', response['attributes']['company']
#         assert_equal 'j.werkhoven@interflux.com', response['attributes']['email']
#         assert_equal '+61 424 787 652', response['attributes']['mobile']
#         assert_equal 'Requesting LMPA demo', response['attributes']['purpose']
#         assert_equal 'Hello Interflux, please send me your best LMPA expert. We are much interested in soldering with lower temperatures but first need to see your product work on our production line.', response['attributes']['message']
#         assert_equal 'https://lmpa.interflux.com/en/request-free-demo', response['attributes']['source']
#         assert_equal '123.123.123.123', response['attributes']['ip']
#         assert_equal 'Victoria', response['attributes']['ip-region']
#         assert_equal 'Melbourne', response['attributes']['ip-city']
#         assert_equal @belgium.id, response['relationships']['country']['data']['id']
#         assert_equal @australia.id, response['relationships']['ip-country']['data']['id']
#         assert_equal @belgium.id, new_record.country.id
#         assert_equal @belgium.name, new_record.country.name
#         assert_enqueued_jobs 1, only: PostLeadToSlackJob
#       end
#
#       test 'Public users can create incomplete leads' do
#         json = {
#           data: {
#             type: 'products',
#             attributes: {
#               name: nil,
#               company: nil,
#               email: nil,
#               mobile: nil,
#               purpose: 'Requesting LMPA demo',
#               message: nil,
#               source: 'https://lmpa.interflux.com/en/request-free-demo',
#               ip: nil,
#               'ip-region': nil,
#               'ip-city': nil
#             }
#           }
#         }
#         assert_equal 2, Lead.count
#         assert_enqueued_jobs 0
#
#         post '/v1/public/leads', params: json, headers: public_header
#
#         assert_response 201
#         assert_equal 3, Lead.count
#         response = JSON.parse(@response.body)['data']
#         refute_empty response['id']
#         assert_equal 11, response['attributes'].count
#         assert_nil response['attributes']['name']
#         assert_nil response['attributes']['company']
#         assert_nil response['attributes']['email']
#         assert_nil response['attributes']['mobile']
#         assert_equal 'Requesting LMPA demo', response['attributes']['purpose']
#         assert_nil response['attributes']['message']
#         assert_equal 'https://lmpa.interflux.com/en/request-free-demo', response['attributes']['source']
#         assert_nil response['attributes']['ip']
#         assert_nil response['attributes']['ip-region']
#         assert_nil response['attributes']['ip-city']
#         assert_equal 2, response['relationships'].count
#         assert_nil response['relationships']['country']['data']
#         assert_nil response['relationships']['ip-country']['data']
#         assert_enqueued_jobs 1, only: PostLeadToSlackJob
#       end
#
#       test 'Public users cannot update leads' do
#         put "/v1/public/leads/#{@lead.id}", headers: public_header
#         assert_response 403
#       end
#
#       test 'Public users cannot delete leads' do
#         delete "/v1/public/leads/#{@lead.id}", headers: public_header
#         assert_response 403
#       end
#     end
#   end
# end
