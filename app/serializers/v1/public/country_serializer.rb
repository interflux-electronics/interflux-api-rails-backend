module V1
  module Public
    class CountrySerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 :latitude,
                 :longitude

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
