module V1
  module Public
    class CompanyMarketSerializer < ApplicationSerializer
      attributes :rank_among_companies,
                 :rank_among_countries,
                 :company_is_recommended

      belongs_to :company
      belongs_to :country
    end
  end
end
