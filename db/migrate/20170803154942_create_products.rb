# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.integer :product_group_id
      t.integer :product_sub_group_id
      t.boolean :public, default: false
      t.text :pitch
      t.text :body

      t.timestamps
    end
  end
end
