module V1
  class AdminController < ApplicationController
    # before_action :authorize_request
    #
    # def authorize_request
    #   header = request.headers['Authorization']
    #   header = header.split(' ').last if header
    #   begin
    #     @decoded = JsonWebToken.new(data).decode
    #     @current_user = User.find(@decoded[:user_id])
    #   rescue ActiveRecord::RecordNotFound => e
    #     byebug
    #     unauthorized(e.message)
    #   rescue JWT::DecodeError => e
    #     byebug
    #     unauthorized(e.message)
    #   end
    # end
  end
end
