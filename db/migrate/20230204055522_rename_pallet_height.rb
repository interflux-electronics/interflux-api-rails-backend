class RenamePalletHeight < ActiveRecord::Migration[6.1]
  def change
    rename_column :simulation_requests, :pallet_height, :pallet_length
  end
end
