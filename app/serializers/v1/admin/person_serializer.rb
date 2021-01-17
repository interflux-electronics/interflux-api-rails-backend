module V1
  module Admin
    class PersonSerializer < ApplicationSerializer
      attributes :first_name,
                 :last_name,
                 :chinese_name,
                 :full_name,
                 :email,
                 :phone

      has_many :companies, if: requested?('companies')
      has_many :company_members, if: requested?('company_members')
    end
  end
end
