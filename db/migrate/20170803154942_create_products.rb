# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.boolean :public, default: false
      t.string :name
      t.string :pitch
      t.string :product_type
      t.string :slug
      t.text :corpus

      t.timestamps
    end
  end
end
