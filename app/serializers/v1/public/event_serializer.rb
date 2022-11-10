module V1
  module Public
    class EventSerializer < ApplicationSerializer
      attributes :name,
                 :start_date,
                 :end_date,
                 :location,
                 :call_to_action
    end
  end
end
