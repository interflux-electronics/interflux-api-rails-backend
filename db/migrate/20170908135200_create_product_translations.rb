class CreateProductTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_translations do |t|
      t.text :body
      t.text :pitch

      t.integer :product_id
      t.integer :language_id

      t.timestamps
    end
  end
end
