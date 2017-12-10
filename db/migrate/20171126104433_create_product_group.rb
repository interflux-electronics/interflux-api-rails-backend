

class CreateProductGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :product_groups do |t|
      t.string :single
      t.string :plural
      t.string :slug
    end
  end
end
