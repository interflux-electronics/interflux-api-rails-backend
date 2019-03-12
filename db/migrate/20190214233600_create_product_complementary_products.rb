class CreateProductComplementaryProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :product_complementary_products, id: :uuid do |t|
      t.uuid :product_serie_id
      t.uuid :complement_id

      t.timestamps
    end

    # add_index :product_complementary_products, :slug, unique: true
    # add_index :product_complementary_products, :name, unique: true
    # add_index :product_complementary_products, :public
    add_index :product_complementary_products, :product_serie_id
    add_index :product_complementary_products, :complement_id
  end
end
