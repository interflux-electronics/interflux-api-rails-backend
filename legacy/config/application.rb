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

    # To include the JSON web token encode and decode methods
    # https://www.pluralsight.com/guides/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api
    config.autoload_paths << Rails.root.join('lib')

    # TODO: Make CORS strict once API is working
    # config.middleware.insert_before 0, Rack::Cors do
    #   domain = '*'
    #   domain = 'https://admin.interflux.com' if Rails.env.production?
    #   methods = [:get, :post, :put, :delete, :options]
    #   allow do
    #     origins domain
    #     resource '/admin/*', headers: :any, methods: methods
    #   end
    #   allow do
    #     origins '*'
    #     resource '/public/*', headers: :any, methods: methods
    #   end
    # end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post patch delete options]
      end
    end

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end