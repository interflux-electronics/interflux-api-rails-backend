class RenameProductFamilyRank < ActiveRecord::Migration[6.1]
  def change
    rename_column :product_families, :order, :rank
  end
end
