class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies, id: :uuid do |t|
      t.string :code
      t.string :name
      t.string :symbol

      t.timestamps
    end

    add_index :currencies, :code, unique: true
  end
end
