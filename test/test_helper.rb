ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Make all fixtures available to every test
    fixtures :all

    # Generate a valid JWT token for an admin user
    # def admin_user_token
    #   JsonWebToken.encode(user_id: users('admin_user').id)
    # end

    # Return the HTTP headers a logged in admin would be sending
    # def admin_header
    #   {
    #     'Authorization': admin_user_token,
    #     'Content-Type': "application/vnd.api+json"
    #   }
    # end

    def public_header
      {
        'Content-Type': 'application/vnd.api+json'
      }
    end
  end
end
