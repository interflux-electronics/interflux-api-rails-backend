class CreateProductVariations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_variations, id: :uuid do |t|
      t.string :reference
      t.string :description

      t.uuid :product_id

      t.timestamps
    end

    add_index :products, :reference, unique: true
  end
end
