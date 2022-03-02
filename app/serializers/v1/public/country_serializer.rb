module V1
  module Public
    class CountrySerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 :latitude,
                 :longitude
    end
  end
end
