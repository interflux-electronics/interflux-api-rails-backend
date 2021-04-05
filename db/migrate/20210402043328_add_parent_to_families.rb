class AddParentToFamilies < ActiveRecord::Migration[6.1]
  def change
    add_column :product_families, :product_family_id, :string
  end
end
