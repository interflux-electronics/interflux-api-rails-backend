module V1
  module Public
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
