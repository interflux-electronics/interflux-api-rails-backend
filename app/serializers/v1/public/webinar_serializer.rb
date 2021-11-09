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
    end
  end
end
