# == Schema Information
#
# Table name: company_members
#
#  id         :bigint(8)        not null, primary key
#  company_id :uuid
#  person_id  :uuid
#  title      :string
#  email      :string
#  phone      :string
#  public     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CompanyMember < ApplicationRecord
  belongs_to :company
  belongs_to :person
end
