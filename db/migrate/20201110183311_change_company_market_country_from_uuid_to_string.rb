class ChangeCompanyMarketCountryFromUuidToString < ActiveRecord::Migration[5.1]
  def change
    change_column :company_markets, :company_id, :string
  end
end
