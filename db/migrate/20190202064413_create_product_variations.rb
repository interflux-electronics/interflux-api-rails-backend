class CreateProductVariations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_variations, id: :uuid do |t|
      t.string :code
      t.string :description

      t.uuid :product_id

      t.timestamps
    end

    add_index :product_variations, :code, unique: true
  end
end
