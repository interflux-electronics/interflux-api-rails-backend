require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApiInterfluxCom
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Convert all incoming JSON to snake_case
    # Convert all outgoing JSON to dasherized
    # config.middleware.use OliveBranch::Middleware
    config.middleware.use OliveBranch::Middleware, inflection: 'dash', content_type_check: ->(_content_type) { true }

    # Enables the use of setting and reading cookies from controllers
    config.middleware.use ActionDispatch::Cookies

    # Allow public endpoints to be hit from any origin (CORS)
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/v1/public/*',
                 headers: :any,
                 methods: %i[options get post patch delete]
      end
      allow do
        origins '*'
        resource '/v1/admin/*',
                 headers: :any,
                 methods: %i[options get post patch delete]
      end
    end
  end
end
