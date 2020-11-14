module V1
  module Admin
    class CompanyMarketSerializer < ApplicationSerializer
      belongs_to :company
      belongs_to :country
    end
  end
end
