require 'test_helper'

module V1
  module Public
    class LeadsIntegrationTest < ActionDispatch::IntegrationTest
      def setup
        @header = public_header
      end

      # {"data"=>{"attributes"=>{"name"=>"Jan", "company"=>"Interflux", "email"=>"j.werkhoven@interflux.com", "mobile"=>"+61424787652", "message"=>"Tell me more.", "purpose"=>"Request LMPA demo", "source"=>"http://localhost:4200/en/request-free-demo", "ip"=>"49.184.169.106", "ip_region"=>"Victoria", "ip_city"=>"Melbourne"}, "relationships"=>{"country"=>{"data"=>{"type"=>"countries", "id"=>"cb39848c-821e-4e04-8534-f18347c08242"}}, "ip_country"=>{"data"=>nil}}, "type"=>"leads"}, "lead"=>{}}
      test 'can create lead' do
        # params = {"data"=>{"attributes"=>{"name"=>"Jan", "company"=>"Interflux", "email"=>"j.werkhoven@interflux.com", "mobile"=>"+61424787652", "message"=>"Tell me more.", "purpose"=>"Request LMPA demo", "source"=>"http://localhost:4200/en/request-free-demo", "ip"=>"49.184.169.106", "ip_region"=>"Victoria", "ip_city"=>"Melbourne"}, "relationships"=>{"country"=>{"data"=>{"type"=>"countries", "id"=>"cb39848c-821e-4e04-8534-f18347c08242"}}, "ip_country"=>{"data"=>nil}}, "type"=>"leads"}, "lead"=>{}}
        params = { data: { attributes: { name: "Jan", company: "Interflux", email: "j.werkhoven@interflux.com", mobile: "+61424787652", message: "Tell me more.", purpose: "Request LMPA demo", source: "http://localhost:4200/en/request-free-demo", "ip"=>"49.184.169.106", "ip_region"=>"Victoria", "ip_city"=>"Melbourne"}, "relationships"=>{"country"=>{"data"=>{"type"=>"countries", "id"=>"cb39848c-821e-4e04-8534-f18347c08242"}}, "ip_country"=>{"data"=>nil}}, "type"=>"leads"}, "lead"=>{}}
        post '/v1/public/leads', headers: @header, params: params
        assert_response 201
        json = JSON.parse(@response.body)
        assert_equal 2, json['data'].length
      end
    end
  end
end
