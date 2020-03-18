# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  module Admin
    class AuthenticationController < ApplicationController
      def token
        return 401 unless email && password

        user = User.find_by(email: email)

        return 401 if user.nil?

        user = user.authenticate(password)

        return 401 if user.nil?

        payload = { user_id: user.id }
        expiry = Time.now + 24.hours.to_i # TODO: test 24.hours.from_now
        token = JsonWebToken.new(payload, expiry).encode
        json = {
          auth: {
            token: token,
            expiry: expiry.strftime('%m-%d-%Y %H:%M')
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
    end
  end
end
