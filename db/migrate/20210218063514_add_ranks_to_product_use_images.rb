class AddRanksToProductUseImages < ActiveRecord::Migration[5.1]
  def change
    add_column :use_images, :rank_among_uses, :integer
    add_column :use_images, :rank_among_images, :integer
  end
end
