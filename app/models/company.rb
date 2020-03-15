# == Schema Information
#
# Table name: companies
#
#  id            :uuid             not null, primary key
#  slug          :string
#  business_name :string
#  address       :string
#  emails        :string
#  phone         :string
#  fax           :string
#  latitude      :decimal(, )
#  longitude     :decimal(, )
#  country_id    :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  legal_name    :string
#  website       :string
#

class Company < ApplicationRecord
  belongs_to :country

  has_many :company_markets
  has_many :markets, through: :company_markets, source: :country
end
