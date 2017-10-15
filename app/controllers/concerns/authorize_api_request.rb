# frozen_string_literal: true
# # frozen_string_literal: true
#
# # https://www.pluralsight.com/guides/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api
# # https://github.com/nebulab/simple_command
#
# module AuthorizeApiRequest
#   extend ActiveSupport::Concern
#
#   # def initialize(headers = {})
#   #   @headers = headers
#   # end
#
#   # def call
#   def authorize_api_request(headers)
#     @headers = headers
#     user
#   end
#
#   private
#
#   attr_reader :headers
#
#   def user
#     byebug
#     @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
#     @user || errors.add(:token, 'Invalid token') && nil
#   end
#
#   def decoded_auth_token
#     @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
#   end
#
#   def http_auth_header
#     if headers['Authorization'].present?
#       return headers['Authorization'].split(' ').last
#     else
#       errors.add(:token, 'Missing token')
#     end
#     nil
#   end
# end
