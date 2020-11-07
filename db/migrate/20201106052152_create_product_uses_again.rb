class CreateProductUsesAgain < ActiveRecord::Migration[5.1]
  def change
    create_table :product_uses, id: :uuid do |t|
      t.string :product_id
      t.string :use_id

      t.timestamps
    end
  end
end
