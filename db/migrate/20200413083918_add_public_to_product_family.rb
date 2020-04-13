class AddPublicToProductFamily < ActiveRecord::Migration[5.1]
  def change
    add_column :product_families, :public, :boolean, default: false
    add_column :product_families, :order, :integer
  end
end
