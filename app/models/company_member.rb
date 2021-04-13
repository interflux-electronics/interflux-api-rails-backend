class CompanyMember < ApplicationRecord
  belongs_to :company
  belongs_to :person
end
