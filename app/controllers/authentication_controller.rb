# frozen_string_literal: true

class AuthenticationController < ApplicationController
  # skip_before_action :authenticate_request

  def authenticate
    user = User.find_by(email: params[:email])
    return invalid_login unless user && user.authenticate(params[:password])
    JsonWebToken.encode(user_id: user.id)
    render json: { auth_token: JsonWebToken.encode(user_id: user.id) }
  end

  private

  def invalid_login
    render status: 401, json: {
      errors: [{
        status: '401',
        code: 'invalid_login',
        detail: 'Your login credentials are invalid.'
      }]
    }
  end
end
