class CreateProductFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :product_families, id: :uuid do |t|
      t.string :slug
      t.string :code
      t.string :name_single
      t.string :name_plural

      t.timestamps
    end

    add_index :product_families, :slug, unique: true
    add_index :product_families, :name_single, unique: true
    add_index :product_families, :name_plural, unique: true
  end
end
