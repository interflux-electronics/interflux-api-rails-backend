# == Schema Information
#
# Table name: company_markets
#
#  id         :uuid             not null, primary key
#  company_id :uuid
#  country_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CompanyMarket < ApplicationRecord
  belongs_to :company
  belongs_to :country
end
