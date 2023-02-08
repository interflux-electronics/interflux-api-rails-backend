module V1
  module Public
    class EventSerializer < ApplicationSerializer
      attributes :name,
                 :city,
                 :dates,
                 :start_date,
                 :end_date,
                 :description

      belongs_to :country
    end
  end
end
