module V1
  module Admin
    class CompanyMemberSerializer < ApplicationSerializer
      attributes :title,
                 :email,
                 :phone,
                 :public,
                 :public_title,
                 :public_email,
                 :public_phone

      belongs_to :company
      belongs_to :person
    end
  end
end
