

# Documentation:
# http://jsonapi-resources.com/v0.9/guide/configuration.html#Override-the-defaults

JSONAPI.configure do |config|
  config.always_include_to_one_linkage_data = true
  config.always_include_to_many_linkage_data = true
end
