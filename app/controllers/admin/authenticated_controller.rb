# frozen_string_literal: true

module Admin
  class AuthenticatedController < ApplicationController
    before_action :authorize_request

    private

    def authorize_request
      return missing_header if request.headers['Authorization'].nil?
      token = JsonWebToken.decode(request.headers['Authorization'].split(' ').last)
      return invalid_token if token.nil?
      user = User.find_by(id: token['user_id'])
      return missing_user if user.nil?
      return no_permission unless user.can_access_admin?
    end

    def missing_header
      render status: 401, json: {
        errors: [{
          status: '401',
          code: 'missing-header',
          detail: 'The header of your request is missing the Authorization field.'
        }]
      }
    end

    def invalid_token
      render status: 401, json: {
        errors: [{
          status: '401',
          code: 'invalid-token',
          detail: 'Your JWT token is either invalid or expired.'
        }]
      }
    end

    def missing_user
      render status: 401, json: {
        errors: [{
          status: '401',
          code: 'missing-user',
          detail: 'No user was found for your authentication token.'
        }]
      }
    end

    def no_permission
      render status: 401, json: {
        errors: [{
          status: '401',
          code: 'no-permission',
          detail: 'User does not have permission.'
        }]
      }
    end
  end
end
