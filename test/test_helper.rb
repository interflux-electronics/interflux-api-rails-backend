# frozen_string_literal: true

require 'rails/test_help'
require File.expand_path('../../config/environment', __FILE__)
# include Rack::Minitest::JSON

# To improve the outputs of `rails test` (Minitest)
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
