module V1
  module Admin
    class CompanyMemberSerializer < ApplicationSerializer
      belongs_to :company
      belongs_to :person
    end
  end
end
