class CreateProductSeries < ActiveRecord::Migration[5.1]
  def change
    create_table :product_series, id: :uuid do |t|
      t.string :slug
      t.string :code
      t.string :name
      t.boolean :public, default: false
      t.boolean :continued, default: true

      t.uuid :product_family_id

      t.timestamps
    end

    add_index :product_series, :slug, unique: true
    add_index :product_series, :code, unique: true
    add_index :product_series, :name, unique: true
    add_index :product_series, :public
    add_index :product_series, :continued
    add_index :product_series, :product_family_id
  end
end
