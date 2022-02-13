class AddRecommendationToCompanyMarkets < ActiveRecord::Migration[6.1]
  def change
    add_column :company_markets, :company_is_recommended, :boolean, default: false
  end
end
