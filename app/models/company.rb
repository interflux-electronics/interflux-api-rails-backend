# == Schema Information
#
# Table name: companies
#
#  id               :uuid             not null, primary key
#  slug             :string
#  business_name    :string
#  address          :string
#  emails           :string
#  phone            :string
#  fax              :string
#  latitude         :decimal(, )
#  longitude        :decimal(, )
#  country_id       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  legal_name       :string
#  website          :string
#  public           :boolean
#  order            :integer
#  email_general    :string
#  email_support    :string
#  email_orders     :string
#  email_accounting :string
#

class Company < ApplicationRecord
  belongs_to :country, optional: true

  has_many :company_markets, dependent: :destroy
  has_many :markets, through: :company_markets, source: :country

  has_many :company_members, dependent: :destroy
  has_many :people, through: :company_members, source: :person

  alias_attribute :members, :people

  has_many :public_members, -> { where(public: true) }, class_name: 'CompanyMember'
end
