# frozen_string_literal: true

class CreateProductTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_translations do |t|
      t.integer :product_id
      t.string :locale
      t.text :pitch
      t.text :corpus

      t.timestamps
    end
  end
end
