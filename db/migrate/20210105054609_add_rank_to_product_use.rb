class AddRankToProductUse < ActiveRecord::Migration[5.1]
  def change
    add_column :product_uses, :rank, :integer
  end
end
