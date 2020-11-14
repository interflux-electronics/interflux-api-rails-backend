module V1
  module Admin
    class CompanyMemberSerializer < ApplicationSerializer
      attributes :title,
                 :email,
                 :phone,
                 :public

      belongs_to :company
      belongs_to :person
    end
  end
end
