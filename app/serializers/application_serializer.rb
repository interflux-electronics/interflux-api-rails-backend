# Things to apply to all serializers
class ApplicationSerializer
  include JSONAPI::Serializer
  include JsonApiSerializer

  def self.inherited(subclass)
    # Include Fast JSON API on every serializer
    subclass.send :include, FastJsonapi::ObjectSerializer

    # Dasherise all JSON keys
    subclass.send :set_key_transform, :dash

    # Enable 15 minute caching if production
    # TODO: only cache if in production
    # should_cache = Rails.env.production?
    subclass.send :cache_options, store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 15.minutes

    # subclass.define_method :is_included? do |params, model_name|
    #   byebug
    #   params && params['include'] && (params['include'].split(',').include? model_name)
    # end
  end
end
