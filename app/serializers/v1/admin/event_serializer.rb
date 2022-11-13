module V1
  module Admin
    class EventSerializer < ApplicationSerializer
      attributes :name,
                 :city,
                 :dates,
                 :description

      belongs_to :country
    end
  end
end
