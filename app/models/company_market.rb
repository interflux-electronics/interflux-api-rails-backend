class CompanyMarket < ApplicationRecord
  belongs_to :company
  belongs_to :country
end
