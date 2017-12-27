class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.boolean :public, default: false
      t.text :pitch
      t.text :body

      t.integer :main_category_id
      t.integer :sub_category_id

      t.timestamps
    end
  end
end
