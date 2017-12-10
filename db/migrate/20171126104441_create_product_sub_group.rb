

class CreateProductSubGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :product_sub_groups do |t|
      t.integer :product_group_id
      t.string :single
      t.string :plural
      t.string :slug
    end
  end
end
