class Company < ApplicationRecord
  belongs_to :country, optional: true

  has_many :company_markets, dependent: :destroy
  has_many :markets, through: :company_markets, source: :country

  has_many :company_members, dependent: :destroy
  has_many :people, through: :company_members, source: :person

  alias_attribute :members, :people

  has_many :public_members, -> { where(public: true) }, class_name: 'CompanyMember'
end
