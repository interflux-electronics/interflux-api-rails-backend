module V1
  module Admin
    class WebinarSerializer < ApplicationSerializer
      attributes :topic,
                 :blurb,
                 :url,
                 :start_time,
                 :duration,
                 :public

      belongs_to :person
    end
  end
end
