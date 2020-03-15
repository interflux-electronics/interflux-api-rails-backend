class CreateCompanyMarkets < ActiveRecord::Migration[5.1]
  def change
    create_table :company_markets do |t|
      t.uuid :company_id
      t.uuid :country_id

      t.timestamps
    end

    add_index :company_markets, :company_id
    add_index :company_markets, :country_id
  end
end
