module Admin
  class AuthenticatedController < ApplicationController
    before_action :authorize_request

    attr_accessor :user

    private

    def authorize_request
      return missing_header if request.headers['Authorization'].nil?
      token = JsonWebToken.decode(request.headers['Authorization'].split(' ').last)
      return invalid_token if token.nil?
      user ||= User.find_by_id(token['user_id'])
      return missing_user if user.nil?
      return no_permission unless user.can_access_admin?
    end

    def missing_header
      json_error(401, 'missing-header', 'The header of your request is missing the Authorization field.')
    end

    def invalid_token
      json_error(401, 'invalid-token', 'Your JWT token is either invalid or expired.')
    end

    def missing_user
      json_error(401, 'missing-user', 'No user was found for your authentication token.')
    end

    def no_permission
      json_error(401, 'no-permission', 'User does not have permission.')
    end
  end
end
