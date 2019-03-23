# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  class AdminController < ApplicationController
    before_action :authorize_request

    private

    # Needed?
    # attr_reader :auth_user

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

      # TODO: Check if user has permissions to index/show/create/update/delete this resources
      # return permission_error if user.permissions.include(...)

      # resource_klass.name
      # __method__

      # Needed?
      # Finally, make the authenticated user available to the
      # controller that inherits this AdminController
      # @auth_user = user
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
      render_error(401, 'no-auth-header', 'You are not authorized to make this request. Reason: the request is missing the Authorization header.')
    end

    def decode_error
      render_error(401, 'unable-to-decode', 'You are not authorized to make this request. Reason: the token in Authorization header cannot be decoded.')
    end

    def expiration_error
      render_error(401, 'token-expired', 'You are not authorized to make this request. Reason: the auth token has expired.')
    end

    def user_id_error
      render_error(401, 'no-user-id', 'You are not authorized to make this request. Reason: the auth token does not contain a user ID.')
    end

    def user_error
      render_error(401, 'no-auth-user', 'You are not authorized to make this request. Reason: no user was found matching the user ID inside the auth token.')
    end

    def permission_error
      render_error(403, 'no-permission', 'You are not authorized to make this request. Reason: though this user is correctly authenticated, this user does not have permissions to perform this particular request.')
    end
  end
end
