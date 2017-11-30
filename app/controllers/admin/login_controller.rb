# frozen_string_literal: true

module Admin
  class LoginController < ApplicationController
    def authenticate
      user = User.find_by(email: params[:email])
      return invalid_login unless user && user.authenticate(params[:password])
      JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: JsonWebToken.encode(user_id: user.id) }
    end

    private

    def user_params
      params.require(:authentication).permit(:email, :password)
    end

    def invalid_login
      render status: 401, json: {
        errors: [{
          status: '401',
          code: 'invalid-login',
          detail: 'Your login credentials are invalid.'
        }]
      }
    end
  end
end
