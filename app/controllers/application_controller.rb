# frozen_string_literal: true

class ApplicationController < JSONAPI::ResourceController
  # include AuthorizeApiRequest

  # protect_from_forgery with: :null_session
  # before_action :authenticate_request
  # attr_reader :current_user

  # prepend SimpleCommand

  # private

  # def authenticate_request
  #   # @current_user = AuthorizeApiRequest.call(request.headers).result
  #   @current_user = call(request.headers).result
  #   render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  # end
end
