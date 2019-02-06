# == Schema Information
#
# Table name: country_currencies
#
#  id          :uuid             not null, primary key
#  country_id  :uuid
#  currency_id :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CountryCurrency < ApplicationRecord
  belongs_to :country
  belongs_to :currency
end
