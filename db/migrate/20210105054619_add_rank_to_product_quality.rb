class AddRankToProductQuality < ActiveRecord::Migration[5.1]
  def change
    add_column :product_qualities, :rank, :integer
  end
end
