# == Schema Information
#
# Table name: company_markets
#
#  id                     :uuid             not null, primary key
#  company_is_recommended :boolean          default(FALSE)
#  rank_among_companies   :integer
#  rank_among_countries   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :uuid
#  country_id             :string
#
class CompanyMarket < ApplicationRecord
  belongs_to :company
  belongs_to :country
end
