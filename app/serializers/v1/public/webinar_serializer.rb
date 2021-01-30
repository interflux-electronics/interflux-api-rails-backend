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
    end
  end
end
