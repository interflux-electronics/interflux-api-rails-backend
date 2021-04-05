class RemovePublicFromFamilies < ActiveRecord::Migration[6.1]
  def change
    remove_column :product_families, :public
  end
end
