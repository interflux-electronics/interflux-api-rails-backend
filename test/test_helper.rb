# To avoid bug with require test_help
# https://github.com/burke/zeus/issues/474
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

# To improve the outputs of `rails test` (Minitest)
# Without the test suite stops at first failed test
require 'minitest/reporters'

# Lists all tests run, green for passed, red for failed
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Shows green dots for passes and red error messages for failed specs
# Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

module ActiveSupport
  class TestCase
    # Make all fixtures available to every test
    fixtures :all

    # Generate a valid JWT token for an admin user
    def admin_user_token
      JsonWebToken.encode(user_id: users('admin_user').id)
    end

    # Return the HTTP headers a logged in admin would be sending
    def admin_header
      { 'Authorization': admin_user_token }
    end
  end
end
