class CreateProductComplements < ActiveRecord::Migration[5.1]
  def change
    create_table :product_complements, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :complement_id

      t.timestamps
    end

    add_index :product_complements, :product_id
    add_index :product_complements, :complement_id
  end
end
