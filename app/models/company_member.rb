# == Schema Information
#
# Table name: company_members
#
#  id                   :uuid             not null, primary key
#  email                :string
#  landline             :string
#  phone                :string
#  public               :boolean          default(FALSE)
#  public_email         :boolean          default(FALSE)
#  public_landline      :boolean          default(FALSE)
#  public_phone         :boolean          default(FALSE)
#  public_title         :boolean          default(FALSE)
#  rank_among_companies :integer
#  rank_among_members   :integer
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  company_id           :uuid
#  person_id            :uuid
#
# Indexes
#
#  index_company_members_on_company_id  (company_id)
#  index_company_members_on_person_id   (person_id)
#
class CompanyMember < ApplicationRecord
  belongs_to :company
  belongs_to :person
end
