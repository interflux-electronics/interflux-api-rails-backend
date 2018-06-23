class CreateProductUses < ActiveRecord::Migration[5.1]
  def change
    create_table :product_uses, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :use_id
      t.timestamps
    end
  end
end
