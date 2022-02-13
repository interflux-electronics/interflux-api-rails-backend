class AddRankToCompanyMarkets < ActiveRecord::Migration[6.1]
  def change
    add_column :company_markets, :rank_among_companies, :integer
    add_column :company_markets, :rank_among_countries, :integer
  end
end
