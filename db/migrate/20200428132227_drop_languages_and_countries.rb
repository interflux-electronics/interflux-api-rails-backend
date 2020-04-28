class DropLanguagesAndCountries < ActiveRecord::Migration[5.1]
  def up
    drop_table :countries
    drop_table :currencies
    drop_table :languages
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
