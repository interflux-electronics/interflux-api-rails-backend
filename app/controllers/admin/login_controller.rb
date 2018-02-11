module Admin
  class LoginController < ApplicationController
    def authenticate
      user = User.find_by(email: params[:email])
      return invalid_email unless user
      return invalid_password unless user.authenticate(params[:password])
      JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: JsonWebToken.encode(user_id: user.id) }
    end

    private

    def user_params
      params.require(:authentication).permit(:email, :password)
    end

    # TODO:
    # def invalid_login
    #   json_error(401, 'invalid-login', 'Your login credentials are invalid.')
    # end

    def invalid_email
      json_error(401, 'invalid-email', 'There are no users associated with this email.')
    end

    def invalid_password
      json_error(401, 'invalid-password', 'This password is incorrect.')
    end
  end
end
