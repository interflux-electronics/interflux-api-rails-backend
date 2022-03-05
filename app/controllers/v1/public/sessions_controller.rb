require 'net/http'
require 'uri'

module V1
  module Public
    class SessionsController < ApplicationController
      def index
        forbidden
      end

      def show
        forbidden
      end

      def create
        ip = '78.20.198.66'
        # ip = request.remote_ip
        # ip = request.env['HTTP_X_FORWARDED_FOR']

        return no_ip_error if ip == '127.0.0.1'

        api_key = ENV['IP_GEO_API_KEY']

        return no_api_key_error if api_key.nil?

        uri = URI.parse("https://api.ipgeolocation.io/ipgeo?apiKey=#{api_key}&ip=#{ip}")
        response = Net::HTTP.get_response(uri)

        return api_request_error if response.code.to_i != 200

        json = JSON.parse response.body
        props = OpenStruct.new(
          href: params[:href],
          referrer: params[:referrer],
          ip: ip,
          ip_country_id: json['country_code2'],
          ip_timezone: json['time_zone']['name'],
          ip_isp: json['isp'],
          browser_app: params[:browser_app],
          browser_width: params[:browser_width],
          browser_height: params[:browser_height],
          browser_languages: params[:browser_languages]
        )

        session = Session.new(props.to_h).save

        return save_error unless session

        render status: 201, json: { 'ip-country-id': props.ip_country_id }
      end

      def update
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def model_class
        Session
      end

      def serializer_class
        V1::Public::SessionSerializer
      end

      def no_ip_error
        render_error(
          400,
          'no-ip',
          'The IP is 127.0.0.1.'
        )
      end

      def no_api_key_error
        render_error(
          400,
          'no-api-key',
          'The IP_GEO_API_KEY is missing.'
        )
      end

      def api_request_error
        render_error(
          400,
          'api-request-error',
          'The request to api.ipgeolocation.io failed.'
        )
      end

      def save_error
        render_error(
          400,
          'save-error',
          'Something went wrong saving the Session to the database'
        )
      end
    end
  end
end
