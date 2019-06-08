class CreateProductVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :product_variants, id: :uuid do |t|
      t.string :slug
      t.string :code
      t.string :name

      t.uuid :product_id
      t.uuid :container_id

      t.timestamps
    end

    add_index :product_variants, :slug, unique: true
    add_index :product_variants, :code, unique: true
    add_index :product_variants, :name

    add_index :product_variants, :product_id
    add_index :product_variants, :container_id
  end
end
