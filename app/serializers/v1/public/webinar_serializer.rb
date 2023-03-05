module V1
  module Public
    class WebinarSerializer < ApplicationSerializer
      attributes :title,
                 :topic,
                 :audience,
                 :url,
                 :start_time,
                 :duration,
                 :public

      belongs_to :image
      belongs_to :video
      belongs_to :person
      belongs_to :document

      cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.day
    end
  end
end
