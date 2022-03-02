module V1
  module Admin
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
                 :description,
                 :notes,
                 :is_headquarter

      belongs_to :country

      has_many :people, if: requested?('people')
      has_many :markets, if: requested?('markets')
      has_many :company_members, if: requested?('company_members')
      has_many :company_markets, if: requested?('company_markets')
    end
  end
end
