class CreateProductFamilyImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_family_images, id: :uuid do |t|
      t.string :product_family_id
      t.string :image_id

      t.timestamps
    end
  end
end
