# Things to apply to all serializers
class ApplicationSerializer
  include FastJsonapi::ObjectSerializer

  def self.inherited(klass)
    # Include Fast JSON API on every serializer
    klass.send :include, FastJsonapi::ObjectSerializer

    # Dasherise all JSON keys
    klass.send :set_key_transform, :dash

    # Enable 15 minute caching if production
    should_cache = Rails.env.production?
    klass.send :cache_options, enabled: should_cache, cache_length: 15.minutes
  end
end
