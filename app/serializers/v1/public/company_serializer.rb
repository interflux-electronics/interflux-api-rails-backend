module V1
  module Public
    class CompanySerializer < ApplicationSerializer
      attributes :business_name,
                 :legal_name,
                 :address,
                 :phone,
                 :fax,
                 :emails,
                 :website,
                 :latitude,
                 :longitude,
                 :fax,
                 :public,
                 :order

      belongs_to :country

      has_many :public_members, if: requested?('public_members'), serializer: :company_member
    end
  end
end
