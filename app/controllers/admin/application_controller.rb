# frozen_string_literal: true

# module Admin
  class  Admin::ApplicationController < ApplicationController
    # protect_from_forgery with: :null_session

    # For authorizing requests a current_user method must persist the user.
    # Placing it in the application controller makes it accessible to all controllers.
    # https://www.pluralsight.com/guides/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api
    before_action :authenticate_request

  end
# end
