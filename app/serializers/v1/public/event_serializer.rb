module V1
  module Public
    class EventSerializer < ApplicationSerializer
      attributes :name,
                 :city,
                 :dates,
                 :start_date,
                 :end_date,
                 :description,
                 :has_registration_form,
                 :ask_first_name,
                 :ask_last_name,
                 :ask_role,
                 :ask_company

      belongs_to :country
    end
  end
end
