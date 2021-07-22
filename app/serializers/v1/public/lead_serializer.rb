module V1
  module Public
    class LeadSerializer < ApplicationSerializer
      attributes :name,
                 :company,
                 :email,
                 :mobile,
                 :message,
                 :purpose,
                 :source,
                 :ip,
                 :ip_region,
                 :ip_city

      belongs_to :country
      belongs_to :ip_country, serializer: :country
    end
  end
end
