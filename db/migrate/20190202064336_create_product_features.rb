class CreateProductFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :product_features, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :feature_id

      t.timestamps
    end

    add_index :product_features, :product_id
    add_index :product_features, :feature_id
  end
end
