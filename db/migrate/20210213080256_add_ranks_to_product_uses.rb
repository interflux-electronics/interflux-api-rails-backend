class AddRanksToProductUses < ActiveRecord::Migration[5.1]
  def change
    add_column :product_uses, :rank_among_products, :integer
    add_column :product_uses, :rank_among_uses, :integer
    remove_column :product_uses, :rank, :integer
  end
end
