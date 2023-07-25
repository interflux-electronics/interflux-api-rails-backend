# Inspired from:
# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248
#
module V1
  module Auth
    class UserController < ApplicationController
      def show
        return no_cookie if cookie.nil?
        return no_jwt if jwt.nil?
        return no_user_id if user_id.nil?

        record = User.find(user_id)

        return no_user if record.nil?

        # 1. decode_jwt(jwt)
        # 2. verify the expiration
        # 3. 401 if jwt expired (or refresh token??)
        # 4. find user in database
        # 5. 401 if user does not exist
        # 6. return user data

        # payload = {
        #   id: user.id,
        #   email: user.email,
        #   abilities: user.abilities
        # }

        payload = V1::Admin::UserSerializer.new(record).serializable_hash.to_json

        render status: 200, json: payload
      end

      private

      def cookie
        cookies.encrypted[:session]
      end

      def jwt
        JsonWebToken.new(cookie).decode
      end

      def user_id
        jwt[:sub]
      end

      def no_cookie
        render_error(
          401,
          'no-cookie',
          'No session cookie was received.'
        )
      end

      def no_jwt
        render_error(
          401,
          'no-jwt',
          'Session cookie was found, but cannot decode JWT.'
        )
      end

      def no_user_id
        render_error(
          401,
          'no-user-id',
          'JWT decoded, but does not have user ID.'
        )
      end

      def no_user
        render_error(
          401,
          'no-user',
          'User ID found in JWT, but cannot find user with that ID.'
        )
      end
    end
  end
end
