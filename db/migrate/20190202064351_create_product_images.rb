class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :image_id

      t.timestamps
    end

    add_index :product_images, :product_id
    add_index :product_images, :image_id
  end
end
