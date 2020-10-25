class AddRankAndPublicToProductImages < ActiveRecord::Migration[5.1]
  def change
    add_column :product_images, :rank, :integer
    add_column :product_images, :public, :boolean
  end
end
