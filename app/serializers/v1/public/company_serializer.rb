module V1
  module Public
    class CompanySerializer < ApplicationSerializer
      attributes :business_name,
                 :legal_name,
                 :address,
                 :phone,
                 :fax,
                 :email_general,
                 :email_orders,
                 :email_support,
                 :email_accounting,
                 :website,
                 :latitude,
                 :longitude,
                 :fax,
                 :public,
                 :order,
                 :description

      belongs_to :country

      has_many :public_members, if: requested?('public_members'), serializer: :company_member
    end
  end
end
