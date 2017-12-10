

class CreateProductUse < ActiveRecord::Migration[5.1]
  def change
    create_table :product_uses do |t|
      t.string :name
    end
  end
end
