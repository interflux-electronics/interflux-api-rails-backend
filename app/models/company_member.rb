# == Schema Information
#
# Table name: company_members
#
#  company_id   :uuid
#  person_id    :uuid
#  title        :string
#  email        :string
#  phone        :string
#  public       :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  public_title :boolean          default(FALSE)
#  public_email :boolean          default(FALSE)
#  public_phone :boolean          default(FALSE)
#  id           :uuid             not null, primary key
#

class CompanyMember < ApplicationRecord
  belongs_to :company
  belongs_to :person
end
