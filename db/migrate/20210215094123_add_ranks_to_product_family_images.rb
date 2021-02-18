class AddRanksToProductFamilyImages < ActiveRecord::Migration[5.1]
  def change
    add_column :product_family_images, :rank_among_families, :integer
    add_column :product_family_images, :rank_among_images, :integer
  end
end
