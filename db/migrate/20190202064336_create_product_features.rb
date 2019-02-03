class CreateProductFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :product_features, id: :uuid do |t|
      t.string :slug
      t.string :text
      t.boolean :public, default: false

      t.uuid :image_id

      t.timestamps
    end

    add_index :product_features, :slug, unique: true
    add_index :product_features, :text, unique: true
    add_index :product_features, :public
    add_index :product_features, :image_id
  end
end
