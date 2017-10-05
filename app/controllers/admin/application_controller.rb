# frozen_string_literal: true

class Admin::ApplicationController < ApplicationController
  # protect_from_forgery with: :null_session

  # For authorizing requests a current_user method must persist the user.
  # Placing it in the application controller makes it accessible to all controllers.
  # https://www.pluralsight.com/guides/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
