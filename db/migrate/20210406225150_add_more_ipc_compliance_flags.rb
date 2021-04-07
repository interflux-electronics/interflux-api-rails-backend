class AddMoreIpcComplianceFlags < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :complies_with_ipc, :boolean

    add_column :products, :complies_with_ipcjstd004_a, :boolean
    add_column :products, :complies_with_ipcjstd004_b, :boolean
    add_column :products, :complies_with_ipcjstd005, :boolean
  end
end
