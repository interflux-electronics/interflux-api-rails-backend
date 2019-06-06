class CreateProductSubstitutes < ActiveRecord::Migration[5.1]
  def change
    create_table :product_substitutes, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :substitute_id

      t.timestamps
    end

    add_index :product_substitutes, :product_id
    add_index :product_substitutes, :substitute_id
  end
end
