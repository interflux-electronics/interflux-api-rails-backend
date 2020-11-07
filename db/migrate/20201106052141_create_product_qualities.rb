class CreateProductQualities < ActiveRecord::Migration[5.1]
  def change
    create_table :product_qualities, id: :uuid do |t|
      t.string :product_id
      t.string :quality_id

      t.timestamps
    end
  end
end
