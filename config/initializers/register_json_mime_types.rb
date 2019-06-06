# This initializer sets the Content Type of every request to the JSON API MIME
# type `application/vnd.api+json`. We do this to comply with the contract as
# read here: http://jsonapi.org/format/#content-negotiation-servers
# Inspired from: https://blog.codeship.com/the-json-api-spec/
# See also: https://github.com/rails-api/active_model_serializers/issues/1027

api_mime_types = %w[
  application/vnd.api+json
  text/x-json
  application/json
]

Mime::Type.unregister :json
Mime::Type.register 'application/vnd.api+json', :json, api_mime_types
