module V1
  module Admin
    class CompanyMemberSerializer < ApplicationSerializer
      attributes :title,
                 :email,
                 :phone,
                 :landline,
                 :public,
                 :public_title,
                 :public_email,
                 :public_phone,
                 :public_landline,
                 :rank_among_companies,
                 :rank_among_members

      belongs_to :company
      belongs_to :person
    end
  end
end
