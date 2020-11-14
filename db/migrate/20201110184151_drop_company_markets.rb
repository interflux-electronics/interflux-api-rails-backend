class DropCompanyMarkets < ActiveRecord::Migration[5.1]
  def up
    drop_table :company_markets
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
