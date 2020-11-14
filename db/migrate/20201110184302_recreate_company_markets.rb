class RecreateCompanyMarkets < ActiveRecord::Migration[5.1]
  def change
    create_table :company_markets, id: :uuid do |t|
      t.uuid :company_id
      t.string :country_id

      t.timestamps
    end
  end
end
