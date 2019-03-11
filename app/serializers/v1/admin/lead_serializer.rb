module V1
  module Admin
    class LeadSerializer < ApplicationSerializer
      attributes :name,
                 :company,
                 :email,
                 :mobile,
                 :message,
                 :purpose,
                 :source,
                 :ip_region,
                 :ip_city,
                 :ip,
                 :created_at,
                 :updated_at

      belongs_to :country
      belongs_to :ip_country, record_type: :country, serializer: :country
    end
  end
end
