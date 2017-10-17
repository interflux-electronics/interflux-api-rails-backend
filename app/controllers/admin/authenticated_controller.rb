# frozen_string_literal: true

# TODO: make authenticated_user accessible to all subroutes

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

      # TODO: return no_permission if user.can_use_admin
    end

    def missing_header
      render status: 401, json: { error: 'The header of your request is missing the Authorization field' }
    end

    def invalid_token
      render status: 401, json: { error: 'Your JWT token is either invalid or expired' }
    end

    def missing_user
      render status: 401, json: { error: 'No user was found for your authentication token' }
    end

    def no_permission
      render status: 401, json: { error: 'User does not have permission' }
    end
  end
end
