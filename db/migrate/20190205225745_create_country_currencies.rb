class CreateCountryCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :country_currencies, id: :uuid do |t|
      t.uuid :country_id
      t.uuid :currency_id

      t.timestamps
    end

    add_index :country_currencies, :country_id
    add_index :country_currencies, :currency_id
  end
end
