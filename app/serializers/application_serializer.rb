# Things to apply to all serializers
class ApplicationSerializer
  include JSONAPI::Serializer
  include JsonApiSerializer

  def self.inherited(subclass)
    super

    # Include Fast JSON API on every serializer
    subclass.send :include, FastJsonapi::ObjectSerializer

    # Dasherise all JSON keys
    subclass.send :set_key_transform, :dash

    # TODO: only cache Public endpoints in production
    # subclass.send :cache_options, store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 15.minutes
  end
end
