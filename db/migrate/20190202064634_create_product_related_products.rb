class CreateProductRelatedProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :product_related_products, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :related_product_id

      t.timestamps
    end

    add_index :product_related_products, :product_id
    add_index :product_related_products, :related_product_id
  end
end
