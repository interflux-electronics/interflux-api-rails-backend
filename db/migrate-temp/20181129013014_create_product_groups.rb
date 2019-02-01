class CreateProductGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :product_groups, id: :uuid do |t|
      t.string :slug
      t.string :name_single
      t.string :name_plural

      t.uuid :parent_group_id

      t.timestamps
    end

    add_index :product_groups, :slug, unique: true
    add_index :product_groups, :name_single, unique: true
    add_index :product_groups, :name_plural, unique: true
    add_index :product_groups, :parent_group_id
  end
end
