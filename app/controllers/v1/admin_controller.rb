# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  class AdminController < ApplicationController
    before_action :authorize_request

    private

    def authorize_request
      # Make sure the Authorization header exists
      return header_error if auth_header.nil?

      # Decode the token, error if not decodable
      data = decoded_data
      return decode_error if data.nil?

      # Error if the token has expired
      return expiration_error if Time.at(data[:expiry]).past?

      # Find the user, error if it cannot be found
      return user_id_error if data[:user_id].nil?

      user = find_user

      return user_error if user.nil?
    end

    def auth_header
      request.headers['Authorization']
    end

    def decoded_data
      JsonWebToken.new(auth_header).try(:decode)
    end

    def find_user
      User.find(decoded_data[:user_id])
    end

    def header_error
      render_error(401, 'no-auth-header', 'You are not authorized to make this request. The request headers are missing Authorization header.')
    end

    def decode_error
      render_error(401, 'unable-to-decode', 'You are not authorized to make this request. The token in Authorization header cannot be decoded.')
    end

    def expiration_error
      render_error(401, 'token-expired', 'You are not authorized to make this request. The auth token has expired.')
    end

    def user_id_error
      render_error(401, 'no-user-id', 'You are not authorized to make this request. The auth token does not contain a user UUID.')
    end

    def user_error
      render_error(401, 'no-auth-user', 'You are not authorized to make this request. No user was found matching the user UUID inside the auth token.')
    end
  end
end
