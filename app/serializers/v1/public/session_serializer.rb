module V1
  module Public
    class SessionSerializer < ApplicationSerializer
      attribute :country_code do |object|
        object.ip_country_id
      end
    end
  end
end
