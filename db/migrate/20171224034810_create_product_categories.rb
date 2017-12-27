class CreateProductCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :product_categories do |t|
      t.string :slug
      t.string :name_plural
      t.string :name_single
      t.integer :parent_category_id
      t.timestamps
    end
  end
end
