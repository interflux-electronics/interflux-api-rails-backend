# == Schema Information
#
# Table name: country_currencies
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :uuid
#  currency_id :uuid
#
# Indexes
#
#  index_country_currencies_on_country_id   (country_id)
#  index_country_currencies_on_currency_id  (currency_id)
#
class CountryCurrency < ApplicationRecord
  belongs_to :country
  belongs_to :currency
end
