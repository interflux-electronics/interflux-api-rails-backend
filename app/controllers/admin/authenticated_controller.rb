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
      user = User.find(token['user_id'])
      return missing_user if user.nil?

      # TODO: return no_permission if user.can_use_admin
    end

    def missing_header
      render status: 401, json: { error: 'No Authorization field is included in the HTTP header' }
    end

    def invalid_token
      render status: 401, json: { error: 'Invalid JWT authentication token' }
    end

    def missing_user
      render status: 401, json: { error: 'No user found for authentication token' }
    end

    # def no_permission
    #   render status: 401, json: { error: 'User does not have permission' }
    # end
  end
end
