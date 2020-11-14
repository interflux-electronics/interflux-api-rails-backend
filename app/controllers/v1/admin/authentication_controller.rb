# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  module Admin
    class AuthenticationController < ApplicationController
      def token
        return missing_email unless email
        return missing_password unless password

        user = User.find_by(email: email)

        return wrong_email if user.nil?

        auth_user = user.authenticate(password)

        return wrong_password unless auth_user

        payload = { user_id: auth_user.id }
        expiry = 24.hours.from_now.utc
        token = JsonWebToken.new(payload, expiry.to_i).encode
        json = {
          auth: {
            token: token,
            expiry: expiry.strftime('%Y-%m-%d %H:%M:%S %Z'),
            uuid: auth_user.id
          }
        }

        render status: 200, json: json
      end

      private

      def email
        params.permit(:email)[:email]
      end

      def password
        params.permit(:password)[:password]
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
