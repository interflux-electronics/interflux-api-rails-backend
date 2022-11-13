module V1
  module Public
    class EventSerializer < ApplicationSerializer
      attributes :name,
                 :city,
                 :dates,
                 :description

      belongs_to :country
    end
  end
end
