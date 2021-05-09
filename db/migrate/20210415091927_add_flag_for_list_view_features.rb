class AddFlagForListViewFeatures < ActiveRecord::Migration[6.1]
  def change
    add_column :product_uses, :show_on_product_list, :boolean
    add_column :product_qualities, :show_on_product_list, :boolean
  end
end
