class CreateProductTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_translations do |t|
      t.integer :product_id
      t.string :locale
      t.string :name
      t.text :body
      t.text :pitch

      t.timestamps
    end
  end
end
