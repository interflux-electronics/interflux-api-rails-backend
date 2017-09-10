# frozen_string_literal: true

class CreateProductTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_translations do |t|
      t.integer :product_id
      t.string :locale
      t.string :name
      t.text :corpus
      t.text :pitch

      t.timestamps
    end
  end
end
