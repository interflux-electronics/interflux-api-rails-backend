class CreateProductUses < ActiveRecord::Migration[5.1]
  def change
    create_table :product_uses, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :use_id

      t.timestamps
    end

    add_index :product_uses, :product_id
    add_index :product_uses, :use_id
  end
end
