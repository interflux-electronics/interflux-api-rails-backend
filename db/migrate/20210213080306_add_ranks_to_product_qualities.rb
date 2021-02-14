class AddRanksToProductQualities < ActiveRecord::Migration[5.1]
  def change
    add_column :product_qualities, :rank_among_products, :integer
    add_column :product_qualities, :rank_among_qualities, :integer
    # remove_column :product_qualities, :rank, :integer
  end
end
