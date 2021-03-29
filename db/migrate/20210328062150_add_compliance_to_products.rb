class AddComplianceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :complies_with_iso, :boolean
    add_column :products, :complies_with_rohs, :boolean
    add_column :products, :complies_with_iec, :boolean
    add_column :products, :complies_with_ipc, :boolean
    add_column :products, :test_results, :string
  end
end
