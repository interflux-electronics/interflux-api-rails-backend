# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  module Auth
    class TokenController < ApplicationController
      def create
        return missing_email unless email
        return missing_password unless password

        user = User.find_by(email: email)

        return wrong_email if user.nil?

        @auth_user = user.authenticate(password)

        return wrong_password unless @auth_user

        cookies.encrypted[:session] = auth_cookie

        render status: 201
      end

      private

      def auth_cookie
        {
          value: jwt,
          httponly: true,
          expires: 30.days.from_now,
          secure: true,
          same_site: :none
        }
      end

      def jwt
        payload = {
          sub: @auth_user.id,
          email: @auth_user.email,
          exp: 30.days.from_now.utc.to_i
        }

        JsonWebToken.new(payload).encode
      end

      def strong_params
        params.permit(:email, :password)
      end

      def email
        strong_params[:email]
      end

      def password
        strong_params[:password]
      end

      def missing_email
        render_error(
          401,
          'missing-email',
          'The request payload is missing the param "email".'
        )
      end

      def missing_password
        render_error(
          401,
          'missing-password',
          'The request payload is missing the param "password".'
        )
      end

      def wrong_email
        render_error(
          401,
          'wrong-email',
          'No user was exists for that email.'
        )
      end

      def wrong_password
        render_error(
          401,
          'wrong-password',
          'Incorrect password.'
        )
      end
    end
  end
end
