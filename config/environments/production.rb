Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Attempt to read encrypted secrets from `config/secrets.yml.enc`.
  # Requires an encryption key in `ENV["RAILS_MASTER_KEY"]` or
  # `config/secrets.yml.key`.
  config.read_encrypted_secrets = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "api_interflux_com_#{Rails.env}"
  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  # config.logger = Logger.new (Rails.root.join ("log / production.log"))

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Configuration for sending email via the Sendgrid SMTP servers
  ActionMailer::Base.smtp_settings = {
    user_name: 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
    password: ENV.fetch('SENDGRID_API_KEY', nil), # This is the secret sendgrid API key which was issued during API key creation
    domain: 'em2406.floatplane.dev',
    address: 'smtp.sendgrid.net',
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true
  }

  # Configure CORS.
  # Note that the Interflux front-end live on different domains than their backend.
  # Therefor cross-origin rules are needed.
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '/v1/public/*',
               headers: :any,
               methods: %i[options get post patch delete]
    end

    allow do
      origins 'admin.interflux.com'
      resource '/v1/admin/*',
               headers: :any,
               methods: %i[options get post patch delete],
               credentials: true
    end

    allow do
      origins 'admin.interflux.com'
      resource '/v1/auth/*',
               headers: :any,
               methods: %i[options get post patch delete],
               credentials: true
    end
  end

  # Specify cookies SameSite protection level: either :none, :lax, or :strict.
  #
  # This change is not backwards compatible with earlier Rails versions.
  # It's best enabled when your entire app is migrated and stable on 6.1.
  #
  # https://stackoverflow.com/questions/62487912/rails-6-0-2-1-samesite-attribute-set-to-none-secure-attribute
  #
  config.action_dispatch.cookies_same_site_protection = :none

  # https://pragmaticstudio.com/tutorials/rails-session-cookies-for-api-authentication
  config.action_controller.forgery_protection_origin_check = false
end
