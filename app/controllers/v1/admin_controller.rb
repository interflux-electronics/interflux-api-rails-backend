# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  class AdminController < ApplicationController
    before_action :verify_auth_token

    private

    def verify_auth_token
      # Make sure the Authorization header exists
      return header_error if auth_header.nil?

      # Decode the token, error if not decodable
      data = decoded_data
      return decode_error if data.nil?

      # Error if the token has expired.
      return expiration_error if Time.at(data[:expiry]).past?

      # Error if token doesn't contain a user ID.
      return user_id_error if data[:user_id].nil?

      record = User.find_by(id: decoded_data[:user_id])

      # Error if no user is found for UUID embeded in token.
      return user_error if record.nil?

      # Make record available for other parts of the controller
      @auth_user = record

      nil
    end

    # Checks the abilities on the user record to see if this action is permitted.
    # Set @user_is_able to override this behaviour locally.
    def user_has_ability?(action)
      resource = model_class.name.underscore.pluralize

      @user_is_able || @auth_user.can?("#{action}_#{resource}")
    end

    def auth_header
      request.headers['Authorization']
    end

    def decoded_data
      JsonWebToken.new(auth_header).try(:decode)
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
