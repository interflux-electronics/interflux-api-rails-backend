module JsonApiSerializer
  extend ActiveSupport::Concern

  class_methods do
    # Returns true if the passed model name is found in params['include'] of the request.
    # We use this allow the front-end to optionally include related records in the payload.
    # As per JSON spec: https://jsonapi.org/format/#fetching-includes
    def requested?(model_name)
      proc { |_record, params|
        params && params['include'] && (params['include'].split(',').include? model_name)
      }
    end
  end
end
